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

var chars
var turn_char

# Called when the node enters the scene tree for the first time.
func _ready():
	var i 
	for i in range(3):
		var ch = Character.new("Player "+str(i), 100, 4)
		var new_node = ch.frame
		get_node("Team").add_child(new_node)
		new_node.update()
		new_node.connect('clicked', self, "char_click", [new_node])
		team.append(ch)
	
	for i in range(3):
		var ch = Character.new("Monster "+str(i), 40, 2)
		var new_node = ch.frame
		get_node("Enemies").add_child(new_node)
		new_node.update()
		new_node.connect('clicked', self, "char_click", [new_node])
		enemies.append(ch)
		
	add_cards()
	compute_order()
	turn_char = get_player()

class MyCustomSorter:
	static func sort(a, b):
		if a.speed > b.speed:
			return true
		return false

func compute_order():
	chars = team + enemies
	chars.sort_custom(MyCustomSorter, "sort")
	
func get_player():
	if turn_char != null:
		turn_char.frame.downlight()
	for c in chars:
		c = chars.pop_front()
		if team.has(c) or enemies.has(c):
			chars.append(c)
			turn_char = c
			turn_char.frame.highlight()
			print(c.name)
			return c
	return null


func add_cards():
	selected_card = null
	for i in range(5):
		var c = Attack_card.new("Card "+str(i), 1, 20)
		cards.append(c)
		
		var new_node = c.frame
		new_node.update()
		new_node.connect('clicked', self, "card_click", [new_node])
		new_node.connect('focused', self, "show_card", [new_node, true])
		new_node.connect('unfocused', self, "show_card", [new_node, false])
		get_node("Cards").add_child(new_node)
		
func show_card(node, show):
	if show:
		var dup = node.duplicate()
		$"Card display".add_child(dup)
		$"Card display".rect_scale=Vector2(1.5, 1.5)
	else:
		for n in $"Card display".get_children():
			n.free()

func cast_card(card, source, target):
	if card.card.cost <= turn_char.mana:
		turn_char.mana = turn_char.mana - card.card.cost
		turn_char.frame.update()
		card.card.effect(source, target)
		selected_card.free()
		update_lists()
	selected_card = null
	

func update_lists():
	cards=[]
	for c in $Cards.get_children():
		cards.append(c.card)
		
	team=[]
	for c in $Team.get_children():
		if c.character.hp > 0:
			team.append(c.character)
		else:
			c.call_deferred("free")
	if len(team)==0:
		end_game('lose')
		
	enemies=[]
	for c in $Enemies.get_children():
		if c.character.hp > 0:
			enemies.append(c.character)
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
		if selected_card != card_frame and card_frame.card.cost <= turn_char.mana:
			selected_card = card_frame
			selected_card.select()
		else:
			selected_card = null
	
func _close():
	get_tree().quit()

func next_turn():
	for c in $Cards.get_children():
		c.free()
	turn_char = get_player()
	add_cards()
	turn_char.start_turn()
	

