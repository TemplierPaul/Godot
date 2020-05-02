extends CenterContainer


func show_node(node, show):
	if show:
		var dup = node.duplicate()
		self.add_child(dup)
		self.rect_scale=Vector2(1.5, 1.5)
	else:
		for n in self.get_children():
			n.free()
			
