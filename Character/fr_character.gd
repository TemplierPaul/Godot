extends Node

signal clicked
signal dragged_on
signal updated

# Called when the node enters the scene tree for the first time.
var character
var arrow

var base_style = StyleBoxFlat.new()
var highlight_style = StyleBoxFlat.new()

var highlighted = false

func _ready():
	set_styles()
	downlight()
	
func set_sprite(path, flip_h, scale):
	$Sprite.texture = load(path)
	$Sprite.set('flip_h', flip_h)
	$Sprite.scale=Vector2(scale, scale)

func set_styles():
	base_style.set_bg_color(Color(0, 0, 0, 1))
	base_style.set_border_width_all(0)
	base_style.set("border_blend", false)
	
	highlight_style.set_bg_color(Color(0.364706, 0.364706, 0.364706))
	highlight_style.set_border_width_all(5)
	highlight_style.set("border_blend", true)
	highlight_style.set("border_color", Color(0, 0, 0, 1))
	
	
func highlight():
	$Background.set("custom_styles/panel", highlight_style)
	$aura.set('visible', true)
	
func downlight():
	$Background.set("custom_styles/panel", base_style)
	$aura.set('visible', false)

func update():
	get_node("Bars/HP_bar/HP").text = str(self.character.hp) + '/' + str(self.character.hp_max)
	get_node("Bars/HP_bar").value = 100 * self.character.hp / self.character.hp_max 
	
	if self.character.mana_max > 0:
		get_node("Bars/Mana_bar/Mana").text = str(self.character.mana) + '/' + str(self.character.mana_max)
		get_node("Bars/Mana_bar").value = 100 * self.character.mana / self.character.mana_max
	else:
		$Bars/Mana_bar.visible=false
	get_node("Background/Name").text = str(self.character.name)
	emit_signal('updated')


func _on_click(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			emit_signal("clicked")
			
			
func show_arrow(show=true):
	arrow.set('visible', show)

func can_drop_data(_pos, data):
	return true

func drop_data(_pos, data):
	print("CAST CARD ", data.card.name, " ON ", self.character.name)
	emit_signal("dragged_on")
