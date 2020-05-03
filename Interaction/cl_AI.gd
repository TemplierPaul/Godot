class_name Monster_AI

var rng = RandomNumberGenerator.new()
var character
var ui

signal next_turn
signal completed

func _init(c):
	character = c
	rng.randomize()
	
func act(_ui):
	ui = _ui
	var cards = character.hand
	var i = rng.randi_range(0, len(cards)-1)
	print(cards)
	
	yield(cast(cards[i], self.character), 'completed')
	
	var wait_time = 0.5
	yield(character.frame.get_tree().create_timer(wait_time), "timeout")
	
	
	call_deferred('end')
	return self

func cast(card, target):
	print("Casting")
	yield(ui.cast_card(card, self.character, target, 1), 'completed')
	print("Casted")	

func end():
	emit_signal("next_turn")
