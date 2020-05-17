class_name Deck

var rng = RandomNumberGenerator.new()

var character
var cards = []
var hand = []


func _init(c):
	rng.randomize()
	character = c
	cards = c.set_deck()
	
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
		cards[i].set_frame()
	return hand
