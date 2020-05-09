extends Node2D

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
	
	print(ceil(map_x / h_space))
	print(ceil(map_y / v_space))
	
	for i in range(ceil(map_x / h_space)):
		for j in range(ceil(map_y / v_space)):
			var tile = load("res://Map/tile.tscn").instance()
			tile.rect_scale = Vector2(scale, scale)
			if i%2 == 0:
				pos = Vector2(i*h_space, j*v_space)
			else :
				pos = Vector2(i*h_space, j*v_space + v_space /2)
			tile.rect_position = pos
			add_child(tile)
			
