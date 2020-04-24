extends Control

var Character = load("res://Character/cl_character.gd") 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var l = Panel.new()
	l.rect_size = Vector2(200, 200)
	#l.text = "BONJOUUUUUR"
	
	var new_style = StyleBoxFlat.new()
	new_style.set_bg_color(Color(1, 0, 0, 1))
	l.set("custom_styles/panel", new_style)
	
	add_child(l)
