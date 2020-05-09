extends Control

var card
var selected = false

var base_style 
var highlight_style 

signal clicked
signal dragged
signal focused
signal unfocused
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func link_card(_card):
	self.card = _card
	self.base_style = self.card.base_style
	self.highlight_style = self.card.highlight_style
	update()
	unselect()


func update():
	get_node("Cost background/Cost").text = str(self.card.cost)
	get_node("Name").text = str(self.card.name)
	get_node("Description").text = str(self.card.description)


func _on_click(event):
	if event is InputEventMouseButton and !event.pressed:
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
	$"Cost background".set("custom_styles/panel", base_style)
	self.update()

func mouse_hover():
	#print("Hovering")
	emit_signal("focused")
	
func hover_stop():
	emit_signal("unfocused")

func set_sprite(path, flip_h, scale):
	$Image.texture = load(path)
	$Image.set('flip_h', flip_h)
	$Image.scale=Vector2(scale, scale)
	self.card.sprite_carac = [path, flip_h, scale]
#	print("Editing sprite_carac \n", path, " ", flip_h, " ", scale, " \n", self.card.sprite_carac, "\n")
	return self.card
	
func get_drag_data(_pos):
	var dup = self.duplicate()
	dup.rect_scale=Vector2(0.5, 0.5)
	dup.rect_pivot_offset= - rect_pivot_offset
	set_drag_preview(dup)
	emit_signal("dragged")
	return self
