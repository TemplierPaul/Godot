class_name Deck

var DICT = load("res://Card/card_dict.gd").new()
var rng = RandomNumberGenerator.new()

var character
var cards = []
var hand = []


func _init(c):
	rng.randomize()
	character = c
	self.populate_basic()
	
func populate_basic():
	var new_card
	for i in range(20):
		if i<10:
			new_card = DICT.Attack_card.new("Attack "+str(i), 1, 20)
		else:
			new_card = DICT.Heal_card.new("Heal "+str(i), 2, 25)
		new_card.deck = self
		cards.append(new_card)
	

func get_hand(n=5):
	n = min(n, len(cards))
	hand = []
	var indices = []
	while len(indices)<n:
		var i = rng.randi_range(0, len(cards)-1)
		if ! (indices.has(i)):
			indices.append(i)
	for i in indices:
		hand.append(cards[i])
	return hand
