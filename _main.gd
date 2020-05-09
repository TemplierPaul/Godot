extends Node

var root
var level
var map = null
var combat = null

func _ready():
	root = self #get_tree().get_root()
	map = load("res://Map/TileMap.tscn").instance()
	map.get_node("Menu").connect('start_combat', self, "start_combat")
	level=map
	root.add_child(level)

func start_combat():
	print('Combat')
	root.remove_child(level)
	combat = map.selected.get_combat()
	combat.connect('end_combat', self, "end_combat")
	level=combat
	root.add_child(level)

func end_combat():
	print('END COMBAT')
	map.selected.set_used()
	root.remove_child(combat)
	level=map
	root.add_child(level)
