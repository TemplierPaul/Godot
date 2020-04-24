extends Control

var Character = load("res://Character/cl_character.gd") 
var Card = load("res://Card/cl_card.gd") 
var Attack_card = load("res://Card/cl_attack_card.gd") 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var team = []
var enemies = []
var cards = []
var selected_card=null

var turn_char

# Called when the node enters the scene tree for the first time.
func _ready():
	var i 
	for i in range(3):
		var ch = Character.new("Player "+str(i), 100, 20)
		var new_node = ch.frame
		get_node("Team").add_child(new_node)
		new_node.update()
		new_node.connect('clicked', self, "char_click", [new_node])
		team.append(ch)
	
	for i in range(3):
		var ch = Character.new("Monster "+str(i), 40, 10)
		var new_node = ch.frame
		get_node("Enemies").add_child(new_node)
		new_node.update()
		new_node.connect('clicked', self, "char_click", [new_node])
		enemies.append(ch)
		
	add_cards()


func add_cards():
	var i
	for i in range(5):
		var c = Attack_card.new("Card "+str(i), 1, 20)
		cards.append(c)
		
		var new_node = c.frame
		new_node.update()
		new_node.connect('clicked', self, "card_click", [new_node])
		get_node("Cards").add_child(new_node)
		

func cast_card(card, source, target):
	card.card.effect(source, target)
	selected_card.free()
	selected_card=null
	update_lists()

func update_lists():
	cards=[]
	for c in $Cards.get_children():
		cards.append(c)
		
	team=[]
	for c in $Team.get_children():
		if c.character.hp > 0:
			team.append(c)
		else:
			c.call_deferred("free")
	if len(team)==0:
		end_game('lose')
		
	enemies=[]
	for c in $Enemies.get_children():
		if c.character.hp > 0:
			enemies.append(c)
		else:
			c.call_deferred("free")
	if len(enemies)==0:
		end_game('win')

func end_game(result):
	var res
	if result == "win":
		res = load("res://End/Win.tscn").instance()
	else:
		res = load("res://End/Lose.tscn").instance()
	add_child(res)
	$"Close game".raise()

# Interactions

func char_click(char_frame):
	print(char_frame.character.name, ' clicked')
	if selected_card != null:
		cast_card(selected_card, null, char_frame.character)
		

func card_click(card_frame):
	print(card_frame.card.name, selected_card)
	if selected_card != null:
		selected_card.unselect()
	if selected_card != card_frame:
		selected_card = card_frame
		selected_card.select()
	else:
		selected_card = null
	

func _close():
	get_tree().quit()

func next_turn():
	print(cards)
	for c in $Cards.get_children():
		c.free()
	add_cards()
	

