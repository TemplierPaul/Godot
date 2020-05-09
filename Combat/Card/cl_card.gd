class_name Card

var cost
var name
var description

var frame
var base_style
var highlight_style 
var show_cost=true
var sprite_carac = ["res://icon.png", false, 1]
 
var deck

var Frame =  load("res://Combat/Card/card.tscn") 

func _init(n='Card', c=0):
	self.name = n
	self.cost = c
	self.description = "This is a card, which does card stuff like being a card" 
	
	set_frame()
	
func set_frame():
#	print(sprite_carac)
	custom_style()
	self.frame = Frame.instance()
	self.frame.link_card(self)
	self.frame.set_sprite(sprite_carac[0], sprite_carac[1], sprite_carac[2])

func custom_style():
	base_style = StyleBoxFlat.new()
	base_style.set_bg_color(Color(0, 0, 0, 1))
	base_style.set_border_width_all(2)
	base_style.set("border_blend", false)
	base_style.set("border_color", Color(1, 1, 1, 1))
	
	highlight_style = StyleBoxFlat.new()
	highlight_style.set_bg_color(Color(0.364706, 0.364706, 0.364706))
	highlight_style.set_border_width_all(5)
	highlight_style.set("border_blend", true)
	highlight_style.set("border_color", Color(0, 0, 0, 1))

func effect(caster, target):
	print("Doing stuff on ", target.name)
	return true
