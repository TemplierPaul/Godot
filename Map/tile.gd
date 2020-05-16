extends Control


var red = false
var tile_name='Name'
var x 
var y
var color_unselected = load("res://Map/Tiles/green_tile.png")
var color_selected = load("res://Map/Tiles/red_tile.png")

var combat = null

signal selected
signal unselected

func _ready():
	$Sprite.texture = color_unselected

func set_coords(i, j):
	x = i
	y = j
	set_name(str(i) + ' ; ' + str(j))

func set_name(val='Name'):
	$Name.text = val
	self.tile_name = val

func switch_color():
	if !red:
		$Sprite.texture = color_selected
	else:
		$Sprite.texture = color_unselected
	red = !red
	
func set_used():
	color_unselected = load("res://Map/Tiles/sand_tile.png")
	color_selected = load("res://Map/Tiles/brown_tile.png")
	$Sprite.texture = load("res://Map/Tiles/brown_tile.png")

func get_combat():
	if combat == null:
		combat = load("res://Combat/GUI/CombatUI.tscn").instance()
	return combat

func gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			emit_signal("selected")
