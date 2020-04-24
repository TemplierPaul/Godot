class_name Character

var name
var hp
var hp_max
var mana
var mana_max
var speed
var frame

var Frame =  load("res://Character/character.tscn") 

signal death

func _init(n, _hp, _mana):
	self.name = n
	self.hp = _hp
	self.hp_max = _hp
	self.mana = _mana
	self.mana_max = _mana
	self.speed = 0
	
	self.frame = Frame.instance()
	self.frame.character = self
	self.frame.update()
	
func start_turn():
	self.mana = self.mana_max
	self.frame.update()

func add_hp(value):
	self.hp = self.hp + value
	self.frame.update()
	
func remove_hp(value):
	self.hp = self.hp - value
	self.frame.update()
	if self.hp <= 0:
		self.hp = 0
		emit_signal("death")
