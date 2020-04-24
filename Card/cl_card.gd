class_name Card

var cost
var name
var description
var frame

var Frame =  load("res://Card/card.tscn") 

func _init(n='Card', c=0):
	self.name = n
	self.cost = c
	self.description = "This is a card, which does card stuff like being a card" 
	
	self.frame = Frame.instance()
	self.frame.card = self
	self.frame.update()

func effect(caster, target):
	print("Doing stuff on ", target.name)
	return true
