extends Control

var Character = load("res://Character/cl_character.gd") 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Cont.rect_scale=Vector2(3, 3)
