extends Node2D

var selected = null
var tiles_size
var menu_showing = null

func _ready():
	var scale = 0.5
	var size = 190 * scale / sqrt(3)
	var width= 2*size
	var height= sqrt(3)*size
	var h_space = width*3/4
	var v_space = height
	
	var map_x = 1500
	var map_y = 800
	
	var pos
	
	tiles_size = Vector2(ceil(map_x / h_space - 3), ceil(map_y / v_space - 2))
	
	print(tiles_size)
	
	for i in range(tiles_size[0]):
		for j in range(tiles_size[1]):
			var tile = load("res://Map/tile.tscn").instance()
			tile.connect('selected', self, "tile_selected", [tile])
			tile.rect_scale = Vector2(scale, scale)
			if i%2 == 0:
				pos = Vector2((i+1)*h_space, (j+1)*v_space)
			else :
				pos = Vector2((i+1)*h_space, (j+1)*v_space + v_space /2)
			tile.rect_position = pos
			tile.set_coords(i, j)
			add_child(tile)
	$Menu.raise()

func tile_selected(tile):
	tile.switch_color()
	if selected == tile:
		selected = null
		hide_menu()
	else:
		if selected != null:
			selected.switch_color()
		if tile.x < (tiles_size[0]+1)/2:
			show_menu(true)
		else:
			show_menu(false)
		selected=tile

func show_menu(menu_on_right_side=false):
	if menu_showing == 'right' and menu_on_right_side:
		print("Both right")
		return 0
	elif menu_showing == 'left' and !menu_on_right_side:
		print("Both left")
		return 0
	else:
		print("Different sides")
		hide_menu()
		
	var init 
	var final
	if menu_on_right_side:
		init = Vector2(2000, 400)
		final = Vector2(1500, 400)
		menu_showing = 'right'
	else:
		init = Vector2(0, 400)
		final = Vector2(500, 400)
		menu_showing = 'left'
	$Tween.interpolate_property($Menu, "rect_position",
		init, final, 0.2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func hide_menu():
	var init 
	var final
	if menu_showing == 'left':
		init = Vector2(500, 400)
		final = Vector2(0, 400)
	elif menu_showing == 'right':
		init = Vector2(1500, 400)
		final = Vector2(2000, 400)
	else:
		return 0
	$Tween.interpolate_property($Menu, "rect_position",
			init, final, 0.2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	menu_showing = null
	return self
		


func exit(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			get_tree().quit()
