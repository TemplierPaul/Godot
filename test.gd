extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var c = Card.new()
	add_child(c.frame)
	
	var ch = Character.new()
	add_child(ch.frame)
	ch.frame.rect_position = Vector2(1000, 300)

func can_drop_data(_pos, data):
	return true

func drop_data(_pos, data):
	data.set('visible', true)
