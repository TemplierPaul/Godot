class_name Character

var name
var hp
var hp_max
var mana
var mana_max
var speed
var frame
var alive = true
var deck
var AI

var hand = []

var Frame = load("res://Character/character.tscn") 
var Deck = load("res://Deck/cl_deck.gd") 

signal death
signal completed

func _init(n="Character", _hp=1, _mana=1, ai=false):
	if ai:
		self.AI = Monster_AI.new(self)
	else:
		self.AI = null
	self.name = n
	self.hp = _hp
	self.hp_max = _hp
	self.mana = _mana
	self.mana_max = _mana
	self.speed = 0
	self.deck = Deck.new(self)
	
	self.frame = Frame.instance()
	self.frame.character = self
	self.frame.update()
	set_sprite()
	
func set_sprite():
	self.frame.set_sprite("res://Icon.png", true, 1)
	
func start_turn(ui=null):
	self.mana = self.mana_max
	self.frame.highlight()
	self.frame.update()
	if self.AI != null:
		self.AI.act(ui)
	return self

func end_turn():
	self.frame.downlight()
	self.frame.update()
	
func add_hp(value):
	self.hp = min(self.hp + value, self.hp_max)
	self.frame.update()
	
func remove_hp(value):
	self.hp = self.hp - value
	self.frame.update()
	if self.hp <= 0:
		self.alive=false
		self.hp = 0
		emit_signal("death")

func get_cards():
	hand = self.deck.get_hand(5)
	return hand
