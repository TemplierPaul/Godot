extends Control

var combat =null
onready var scroll = $VBox/MarginContainer/Scroll
onready var scroll_cont = $VBox/MarginContainer/Scroll/Container

signal start_combat

func _ready():
	# Scrollbar settings
	var v_s = scroll.get_v_scrollbar()
	v_s.set('rect_pivot_offset', Vector2(v_s.get('rect_size')[0], v_s.get('rect_size')[1]/2))
	v_s.set('rect_scale', Vector2(2, 1))
	scroll_cont.add_constant_override("separation", 4)
	
	populate()

func add_mission(mission):
	scroll_cont.add_child(mission)
	mission.connect("selected", self, "clicked_mission", [mission])
	mission.connect("start_mission", self, "start_mission", [mission])

func populate():
	for i in range(10):
		var miss = load("res://Mission/mission.tscn").instance()
		add_mission(miss)

func clicked_mission(mission):
	for c in scroll_cont.get_children():
		if c != mission:
			c.get_node('Confirm').set("visible", false)
			
func start_mission(mission):
	combat = load("res://Combat/GUI/CombatUI.tscn").instance()
	emit_signal("start_combat")
