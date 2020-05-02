extends Control

var Character = load("res://Character/cl_character.gd") 
var Porcupine = load("res://Character/Monsters/cl_porcupine.gd") 

# Called when the node enters the scene tree for the first time.
func _ready():
	var c = Robot.new("Name", 50, 0)
	add_child(c.frame)
