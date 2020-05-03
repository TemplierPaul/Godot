extends Card

class_name Lifesteal_card

var dmg
var ratio

signal completed

func _init(n='Card', c=0, _dmg=0, _ratio=1):
	self.name = n
	self.cost = c
	self.dmg = _dmg
	self.ratio = _ratio
	self.description = "Deals " + str(self.dmg) + ' DMG.\n Heals for ' + str(self.dmg * ratio) + ' HP'
	
	set_frame()

func custom_style():
	base_style = StyleBoxFlat.new()
	base_style.set_bg_color(Color(0, 0, 0, 1))
	base_style.set_border_width_all(2)
	base_style.set("border_blend", false)
	base_style.set("border_color", Color("#572ab0"))
	
	highlight_style = StyleBoxFlat.new()
	highlight_style.set_bg_color(Color(0.364706, 0.364706, 0.364706))
	highlight_style.set_border_width_all(5)
	highlight_style.set("border_blend", true)
	highlight_style.set("border_color", Color(0, 0, 0, 1))

func effect(caster, target):
	print("Attacking ", target.name, ' from ', caster.name)
	caster.add_hp(self.dmg * self.ratio)
	yield(target.remove_hp(self.dmg), "completed")
	return true
