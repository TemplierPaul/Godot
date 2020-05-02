extends Control

var character

var base_style = StyleBoxFlat.new()
var highlight_style = StyleBoxFlat.new()

func _ready():
	set_styles()
	downlight()

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
	
func downlight():
	$Background.set("custom_styles/panel", base_style)


