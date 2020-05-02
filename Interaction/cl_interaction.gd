class_name Interaction

var character
var deck

signal next_turn

func _init(c):
	character = c
	deck = c.deck

func get_actions():
	end_turn()

func end_turn():
	emit_signal("next_turn")
	
func cast_card():
	pass
