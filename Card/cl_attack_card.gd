extends Card

class_name Attack_card

var dmg

func _init(n='Card', c=0, _dmg=0):
	self.name = n
	self.cost = c
	self.dmg = _dmg
	self.description = "Deals " + str(self.dmg) + ' DMG'
	
	self.frame = Frame.instance()
	self.frame.card = self
	self.frame.update()

func effect(caster, target):
	print("Attacking ", target.name)
	target.remove_hp(self.dmg)
	return true
