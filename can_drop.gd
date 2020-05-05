extends Panel


func can_drop_data(_pos, data):
	return true

func drop_data(_pos, data):
	print(_pos)
	data.margin_left = _pos[0] + self.margin_left - data.rect_pivot_offset[0]
	data.margin_top = _pos[1] + self.margin_top - data.rect_pivot_offset[1]
	data.rect_size=Vector2(300, 250)
	data.set('visible', true)
