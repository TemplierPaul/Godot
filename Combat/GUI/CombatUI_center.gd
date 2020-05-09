extends CenterContainer


func show_node(node, show):
	if show:
		var dup = node.duplicate()
		self.add_child(dup)
		self.rect_scale=Vector2(1.5, 1.5)
		var vis = node.card.show_cost
		print(vis)
		dup.get_node("Cost background").set("visible", vis)
	else:
		for n in self.get_children():
			n.free()
			
