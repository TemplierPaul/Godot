extends Card

class_name Heal_card

var heal


func _init(n='Card', c=0, _heal=0):
	self.name = n
	self.cost = c
	self.heal = _heal
	self.description = "Heals " + str(self.heal) + ' HP'
	
	set_frame()

func custom_style():
	base_style = StyleBoxFlat.new()
	base_style.set_bg_color(Color(0, 0, 0, 1))
	base_style.set_border_width_all(2)
	base_style.set("border_blend", false)
	base_style.set("border_color", Color("#00ad28"))
	
	highlight_style = StyleBoxFlat.new()
	highlight_style.set_bg_color(Color(0.364706, 0.364706, 0.364706))
	highlight_style.set_border_width_all(5)
	highlight_style.set("border_blend", true)
	highlight_style.set("border_color", Color(0, 0, 0, 1))

func effect(caster, target):
	print("Healing ", target.name)
	target.add_hp(self.heal)
	return true
