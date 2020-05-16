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
var team
var enemies

var rng = RandomNumberGenerator.new()

var hand = []

var Frame = load("res://Combat/Character/character.tscn") 

signal death
signal completed

func _init(n="Character", _hp=1, _mana=1, ai=false):
	rng.randomize()
	if ai:
		self.AI = Monster_AI.new(self)
	else:
		self.AI = null
	self.name = n
	self.hp = _hp
	self.hp_max = _hp
	self.mana = _mana
	self.mana_max = _mana
	self.speed = rng.randi_range(0, 10)
	self.deck = Deck.new(self)
	
	self.frame = Frame.instance()
	self.frame.character = self
	self.frame.update()
	set_sprite()
	
func set_sprite():
	self.frame.set_sprite("res://Icon.png", true, 1)
	
func set_deck():
	var new_card
	var cards=[]
	for i in range(20):
		if i<10:
			new_card = Attack_card.new("Attack "+str(i), 1, 20)
		else:
			new_card = Heal_card.new("Heal "+str(i), 2, 25)
		new_card.deck = self
		cards.append(new_card)
	return cards
	
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
	print(self.name, ' gained HP')
	self.frame.update()
	return self
	
func remove_hp(value):
	self.hp = self.hp - value
	print(self.name, ' lost HP')
	self.frame.update()
	if self.hp <= 0:
		self.alive=false
		self.hp = 0
		emit_signal("death")
	return self

func get_cards():
	hand = self.deck.get_hand(5)
	return hand
	
