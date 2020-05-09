extends Control


signal close
signal start_combat

func _ready():
	pass # Replace with function body.

func close():
	emit_signal("close")


func fight():
	emit_signal("start_combat")

