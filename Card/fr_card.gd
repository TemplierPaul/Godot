extends Node

var card
var selected = false

var base_style = StyleBoxFlat.new()
var highlight_style = StyleBoxFlat.new()

signal clicked
signal focused
signal unfocused

# Called when the node enters the scene tree for the first time.
func _ready():
	set_styles()
	$Background.set("custom_styles/panel", base_style)
	

func set_styles():
	base_style.set_bg_color(Color(0, 0, 0, 1))
	base_style.set_border_width_all(0)
	base_style.set("border_blend", false)
	
	highlight_style.set_bg_color(Color(0.364706, 0.364706, 0.364706))
	highlight_style.set_border_width_all(5)
	highlight_style.set("border_blend", true)
	highlight_style.set("border_color", Color(0, 0, 0, 1))

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
#	print(self.card.name, " Selected")
	$Background.set("custom_styles/panel", highlight_style)
	self.update()
	
func unselect():
#	print(self.card.name, " Unselected")
	$Background.set("custom_styles/panel", base_style)
	self.update()


func mouse_hover():
	#print("Hovering")
	emit_signal("focused")
	
func hover_stop():
	emit_signal("unfocused")


