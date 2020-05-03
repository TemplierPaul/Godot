extends Character

class_name Robot

func _init(n, _hp, _mana).(n, _hp, _mana, false):
	self.frame.set_sprite("res://Character/Players/robot.png", true, 0.25)	
	self.frame.get_node("Sprite").set("position", Vector2(56, 26))

func set_deck():
#	var new_card
	var cards=[]
	for _i in range(5):
		var new_card = Attack_card.new("TURBO PUNCH", 4, 50)
		new_card.frame.set_sprite("res://Card/Card types/bilboshot.png", false, 0.7)
		new_card.deck = self
		cards.append(new_card)
	for _i in range(10):
		var new_card = Attack_card.new("Basic Punch", 1, 10)
		new_card.frame.set_sprite("res://Card/Card types/slash.png", false, 0.7)
		new_card.deck = self
		cards.append(new_card)
	for _i in range(5):
		var new_card = Heal_card.new("Healing", 2, 30)
		new_card.frame.set_sprite("res://Card/Card types/lollislash.png", false, 0.7)
		new_card.deck = self
		cards.append(new_card)
	return cards
