extends Control

func _ready():
	pass # Replace with function body.

signal start_mission
signal selected

func gui_input(event):
	# Press
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			$Confirm.set("visible", !$Confirm.get('visible'))
			emit_signal("selected")
	
func start_mission():
	print("START MISSION")
	emit_signal("start_mission")


func hide_confirm():
	$Confirm.set("visible", false)
