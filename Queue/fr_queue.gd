extends Control

var chars
var index = -1
var current
var turn = 1

signal new_rotation

func _ready():
	pass

func init(team, enemies):
	chars = team + enemies
	chars.sort_custom(MyCustomSorter, "sort")
	for c in chars:
		var l = Label.new()
		l.text = c.name
		$Panel/Players.add_child(l)
	
func get_next():
	index = index+1
	print("Getting n°", index)
	if index == len(chars):
		print("New rotation")
		emit_signal("new_rotation")
		turn = turn +1
		$Turn.text = "Turn " + str(turn)
		index = 0
	var new = chars[index]
	if new.alive:
		print("New Turn: ", new.name)
		if current != null:
			current.frame.disconnect("updated", self, "update_bar")
		new.frame.connect("updated", self, "update_bar")
		current = new
		update_bar()
		return new
	else:
		return get_next()

class MyCustomSorter:
	static func sort(a, b):
		if a.speed > b.speed:
			return true
		return false
	
func update_bar():
	if current.mana_max > 0:
		$Mana.value = 100*current.mana / current.mana_max
		$Mana/Value.text = str(current.mana) + "/" + str(current.mana_max)
	else:
		$Mana.value = 0
		$Mana/Value.text = "No mana"
		
