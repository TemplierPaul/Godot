extends Control

class_name Formation

var characters = []
var containers
var ui = get_parent()
var rng = RandomNumberGenerator.new()

signal all_dead

func _ready():
	rng.randomize()
	ui = get_parent()

func add_char(ch):
	ch.team = self
	var new_node = ch.frame
	add_child(new_node)
	new_node.update()
	new_node.connect('clicked', self, "char_click", [new_node])
	ch.connect('death', self, "death", [new_node])
	characters.append(ch)

func populate(type='robots'):
	characters = []
	for c in get_children():
		c.free()
	var ch
	var names = ["Bob", "Dan", "Martin"]
	for i in range(3):
		if type == 'robots':
			ch = Robot.new(names[i])
		elif type == 'porcupines':
			ch = Porcupine.new()
		else:
			ch = Character.new("Char "+str(i), 40, 2)
		add_char(ch)

func get_random(n=1):
	if ! ui.keep_going or len(characters)<=0:
		return null
	var targets = []
	for i in range(n):
		var j = rng.randi_range(0, len(characters)-1)
		targets.append(characters[j])
	return targets

func set_enemy(enemy_team):
	for c in characters:
		c.team = self
		c.enemies = enemy_team

func char_click(char_frame):
	#print(char_frame.character.name, ' clicked')
	if ui.selected_card != null:
		ui.cast_card(ui.selected_card.card, ui.turn_char, char_frame.character)

func update_list():
	var new_list = []
	for c in characters:
		if c.alive:
			new_list.append(c)
	characters = new_list


func death(char_node):
	print("DEATH " + str(char_node.character.name))
	if char_node.character == ui.turn_char:
		char_node.call_deferred("free")
		ui.call_deferred("next_turn", true)
	else:
		char_node.call_deferred("free")
	if are_all_dead():
		emit_signal("all_dead")
	update_list()

func are_all_dead():
	var alive = 0
	for c in characters:
		if c.alive:
			alive = alive + 1
	return alive == 0

func set_arrow(left_side=true):
	var arr
	if left_side:
		arr = "right_arrow"
	else:
		arr = "left_arrow"
	for c in characters:
			c.frame.arrow = c.frame.get_node(arr)
			
			
