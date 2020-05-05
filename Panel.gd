extends Panel

func get_drag_data(_pos):
	var dup = self.duplicate()
	dup.rect_scale=Vector2(0.5, 0.5)
	dup.rect_pivot_offset= - rect_pivot_offset
#	dup.rect_size=Vector2(100, 100)
#	dup.anchor_left=50
#	dup.anchor_top=50
	set_drag_preview(dup)
	self.set('visible', false)
	# Return self as drag data
	return self
