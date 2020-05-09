extends Panel


signal next_turn


var base_style = StyleBoxFlat.new()
var click_style = StyleBoxFlat.new()
var highlight_style = StyleBoxFlat.new()

var highlighted = false

func _ready():
	set_styles()
	downlight()

func set_styles():
	base_style.set_bg_color(Color(0, 0, 0, 1))
	base_style.set_border_width_all(0)
	base_style.set("border_blend", false)
	
	click_style.set_bg_color(Color(1, 0, 0, 0))
	click_style.set_border_width_all(5)
	click_style.set("border_blend", true)
	click_style.set("border_color", Color(0, 0, 0, 1))
	
	highlight_style.set_bg_color(Color("#3cc776"))
	highlight_style.set_border_width_all(10)
	highlight_style.set("border_blend", true)
	highlight_style.set("border_color", Color('#00c251'))
	
	
func highlight():
	self.set("custom_styles/panel", highlight_style)
	
func downlight():
	self.set("custom_styles/panel", base_style)
	
func click():
	self.set("custom_styles/panel", click_style)

func gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print(event.button_index)
		if event.button_index == 1:
			self.click()
			emit_signal("next_turn")
			
			# Wait 
			yield(get_tree().create_timer(0.5), "timeout")
			
			self.downlight()
			

