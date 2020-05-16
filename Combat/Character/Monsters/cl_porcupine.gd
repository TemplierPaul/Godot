extends Character

class_name Porcupine

var pikes


func _init(n="Angry Porcupine", _hp=70, _mana=0).(n, _hp, _mana, true):
	self.frame.set_sprite("res://Combat/Character/Monsters/porcupine.png", true, 0.3)	
	self.frame.get_node("Bars/Mana_bar").set('visible', false)

func set_deck():
	var new_card
	var cards=[]
	for i in range(7):
		new_card = Attack_card.new("GRRRRR", 0, 30)
		new_card.frame.set_sprite("res://Combat/Character/Monsters/porcupine.png", true, 0.3)
		new_card.show_cost=false
		new_card.deck = self
		cards.append(new_card)
	for i in range(3):
		new_card = Lifesteal_card.new("CHOMP", 0, 20, 1.5)
		new_card.frame.set_sprite("res://Combat/Character/Monsters/porcupine.png", true, 0.4)
		new_card.show_cost=false
		new_card.deck = self
		cards.append(new_card)
	for i in range(2):
		new_card = Heal_card.new("Grass Break", 0, 50)
		new_card.frame.set_sprite("res://Combat/Card/Card types/grass.png", true, 0.25)
		new_card.show_cost=false
		new_card.deck = self
		cards.append(new_card)
	return cards
