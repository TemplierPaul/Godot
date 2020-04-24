extends Node

var card
var selected = false

signal clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update():
	get_node("Cost background/Cost").text = str(self.card.cost)
	get_node("Name").text = str(self.card.name)
	get_node("Description").text = str(self.card.description)


func _on_click(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			self.selected = !self.selected
			emit_signal("clicked")
		
func select():
	print(self.card.name, " Selected")
	self.card.description = "Selected"
	self.update()
	
func unselect():
	print(self.card.name, " Unselected")
	self.card.description = "Unselected"
	self.update()
