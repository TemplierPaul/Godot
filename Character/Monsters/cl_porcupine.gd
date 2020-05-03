extends Character

class_name Porcupine

var pikes

func _init(n, _hp, _mana).("Angry Porcupine", _hp, 0, true):
	self.frame.set_sprite("res://Character/Monsters/porcupine.png", true, 0.3)	
	self.frame.get_node("Bars/Mana_bar").set('visible', false)

func set_deck():
	var new_card
	var cards=[]
	for i in range(10):
		new_card = Attack_card.new("GRRRRR", 0, 20)
		new_card.frame.set_sprite("res://Character/Monsters/porcupine.png", true, 0.3)
		new_card.show_cost=false
		new_card.deck = self
		cards.append(new_card)
	return cards
