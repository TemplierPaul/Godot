class_name Monster_AI

var rng = RandomNumberGenerator.new()
var character
var cards
var ui

signal next_turn

func _init(c):
	character = c
	rng.randomize()
	
func act(_ui):
	ui = _ui
	cards = character.hand
	var wait_time = 0.5
	
	yield(character.frame.get_tree().create_timer(1), "timeout")
	
	yield(cast_random_card(), 'completed')
	yield(character.frame.get_tree().create_timer(wait_time), "timeout")
	
	if ! ui.keep_going:
		return self
	
	yield(cast_random_card(), 'completed')
	yield(character.frame.get_tree().create_timer(wait_time), "timeout")
	
	call_deferred('end')
	return self
	
func cast_random_card():
	if ! ui.keep_going:
		return self
		
	var i = rng.randi_range(0, len(cards)-1)
	
	var target
	if cards[i].name == "Grass Break":
		target = self.character
	else:
		target = character.enemies.get_random(1) [0]
	
	yield(cast(cards[i], target), 'completed')
	
	return self

func cast(card, target):
	if ui.keep_going:
		print("Casting")
		yield(ui.cast_card(card, self.character, target, 1), 'completed')
		print("Casted")	
	cards = []
	for c in ui.get_node('Cards').get_children():
		cards.append(c.card)
	print(cards)

func end():
	emit_signal("next_turn")
