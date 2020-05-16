extends Node

var root
var level
var menu = null
var combat = null
var missions

func _ready():
	root = self #get_tree().get_root()
	menu = load("res://MainMenu/main_menu.tscn").instance()
	missions = menu.get_node("Menu Organizer/Missions/Mission manager")
	missions.connect('start_combat', self, "start_combat")
	level=menu
	root.add_child(level)

func start_combat():
	print('Combat')
	root.remove_child(level)
	combat = missions.combat
	combat.connect('end_combat', self, "end_combat")
	level=combat
	root.add_child(level)

func end_combat():
	print('END COMBAT')
#	menu.selected.set_used()
	root.remove_child(combat)
	level=menu
	root.add_child(level)
