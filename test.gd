extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var r = Robot.new("Robi", 100, 5)
	
	var other_cards = r.set_deck()
	for c in other_cards:
		$Box/Grid.add_child(c.frame)
		
	var cards = r.deck.get_hand(5)
	for c in cards:
		$Box/Grid.add_child(c.frame)

	for i in range(5):
		$Box/Grid.add_child(r.deck.cards[i].frame)
