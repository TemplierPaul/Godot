extends Control

var Character = load("res://Character/cl_character.gd") 
var Porcupine = load("res://Character/Monsters/cl_porcupine.gd") 
var Card = load("res://Card/cl_card.gd") 
var Attack_card = load("res://Card/cl_attack_card.gd") 

var Queue = load("res://Queue/cl_queue.gd") 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var team = []
var enemies = []
var cards = []
var selected_card=null

var queue
var turn_char

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(3):
		var ch = Robot.new("Player "+str(i), 100, 4)
		var new_node = ch.frame
		get_node("Team").add_child(new_node)
		new_node.update()
		new_node.connect('clicked', self, "char_click", [new_node])
		ch.connect('death', self, "death", [new_node])
		team.append(ch)
	
	for i in range(3):
		var ch = Porcupine.new("Monster "+str(i), 40, 0)
		var new_node = ch.frame
		get_node("Enemies").add_child(new_node)
		new_node.update()
		new_node.connect('clicked', self, "char_click", [new_node])
		ch.connect('death', self, "death", [new_node])
		enemies.append(ch)
		
	queue = $Queue
	queue.init(team, enemies)
	print(queue.index)
	turn_char = queue.get_next()
	turn_char.start_turn()
	add_cards(turn_char.get_cards())

func add_cards(cards):
	for c in cards:
		var new_node = c.frame
		new_node.update()
		new_node.connect('clicked', self, "card_click", [new_node])
		new_node.connect('focused', $"Central display", "show_node", [new_node, true])
		new_node.connect('unfocused', $"Central display", "show_node", [new_node, false])
		get_node("Cards").add_child(new_node)
		

func cast_card(card, source, target):
	if card.card.cost <= turn_char.mana:
		turn_char.mana = turn_char.mana - card.card.cost
		turn_char.frame.update()
		card.card.effect(source, target)
		if selected_card != null:
			selected_card.free()
		update_lists()
	selected_card = null
	
func are_all_dead(list):
	var alive = 0
	for c in list:
		if c.alive:
			alive = alive + 1
	return alive == 0


func death(char_node):
	print("DEATH " + str(char_node.character.name))
	if char_node.character == turn_char:
		char_node.call_deferred("free")
		next_turn(false)
	else:
		char_node.call_deferred("free")
	
	if are_all_dead(team):
		end_game('lose')
	if are_all_dead(enemies):
		end_game('win')


func update_lists():
	cards=[]
	for c in $Cards.get_children():
		cards.append(c.card)
	

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
	#print(char_frame.character.name, ' clicked')
	if selected_card != null:
		cast_card(selected_card, null, char_frame.character)
		

func card_click(card_frame):
		#print(card_frame.card.name, selected_card)
		if selected_card != null:
			selected_card.unselect()
		if selected_card != card_frame and card_frame.card.cost <= turn_char.mana:
			selected_card = card_frame
			selected_card.select()
		else:
			selected_card = null
	
func _close():
	get_tree().quit()

func next_turn(prev_freed=false):
	if !prev_freed:
		turn_char.end_turn()
	print("\n> New Turn")
	for c in $Cards.get_children():
		c.free()
	turn_char = queue.get_next()
	add_cards(turn_char.get_cards())
	turn_char.start_turn()
	
