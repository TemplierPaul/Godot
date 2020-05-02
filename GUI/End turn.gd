extends Panel


signal next_turn


var base_style = StyleBoxFlat.new()
var highlight_style = StyleBoxFlat.new()

var highlighted = false

func _ready():
	set_styles()
	downlight()

func set_styles():
	base_style.set_bg_color(Color(0, 0, 0, 1))
	base_style.set_border_width_all(0)
	base_style.set("border_blend", false)
	
	highlight_style.set_bg_color(Color(1, 0, 0, 0))
	highlight_style.set_border_width_all(5)
	highlight_style.set("border_blend", true)
	highlight_style.set("border_color", Color(0, 0, 0, 1))
	
	
func highlight():
	self.set("custom_styles/panel", highlight_style)
	
func downlight():
	self.set("custom_styles/panel", base_style)

func gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print(event.button_index)
		if event.button_index == 1:
			self.highlight()
			emit_signal("next_turn")
			
			# Wait 
			var t = Timer.new()
			t.set_wait_time(0.5)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			self.downlight()
			

