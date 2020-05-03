extends Card

class_name Attack_card

var dmg
#ba0000

func _init(n='Card', c=0, _dmg=0):
	self.name = n
	self.cost = c
	self.dmg = _dmg
	self.description = "Deals " + str(self.dmg) + ' DMG'
	
	set_frame()

func custom_style():
	base_style = StyleBoxFlat.new()
	base_style.set_bg_color(Color(0, 0, 0, 1))
	base_style.set_border_width_all(2)
	base_style.set("border_blend", false)
	base_style.set("border_color", Color("#ba0000"))
	
	highlight_style = StyleBoxFlat.new()
	highlight_style.set_bg_color(Color(0.364706, 0.364706, 0.364706))
	highlight_style.set_border_width_all(5)
	highlight_style.set("border_blend", true)
	highlight_style.set("border_color", Color(0, 0, 0, 1))

func effect(caster, target):
	print("Attacking ", target.name)
	yield(target.remove_hp(self.dmg), "completed")
	return true
