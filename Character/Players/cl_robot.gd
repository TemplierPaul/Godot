extends Character

class_name Robot

func _init(n, _hp, _mana).(n, _hp, _mana):
	self.frame.set_sprite("res://Character/Players/robot.png", true, 0.25)	
	self.frame.get_node("Sprite").set("position", Vector2(56, 26))
