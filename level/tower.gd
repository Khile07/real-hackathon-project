extends Node2D
class_name tower


@onready var tile_layer : TileMapLayer = $tiles

var tiles : Dictionary[Vector2i, tile_resource]
var furthest_x_tile = 1
var highest_y_tile = 1

var the_player : player


func is_move_valid(dir : Vector2i) -> bool:
	#print(tiles)
	var pos : Vector2i = the_player.tile_pos + dir
	if pos in tiles and tiles[pos].tile_type == 0 and not tiles[pos].occupied:
		return true
	print("f")
	return false
		
	
	
func create_tiles():
	for cell in tile_layer.get_used_cells():
		var tile : tile_resource = tile_resource.new()
		tile.tile_type = 0
		tile.occupied = false
		tile.tile_position = cell
		tiles[cell] = tile
		if cell.y > highest_y_tile: highest_y_tile = cell.y
		if cell.x > furthest_x_tile: furthest_x_tile = cell.x
	furthest_x_tile += 1
	highest_y_tile += 1
	for i in range(0,highest_y_tile):
		var tile_a : tile_resource = tile_resource.new()
		tile_a.tile_type = 1
		tile_a.occupied = false
		tile_a.tile_position = Vector2i(-1,i)
		
		var tile_b : tile_resource = tile_resource.new()
		tile_b.tile_type = 1
		tile_b.occupied = false
		tile_b.tile_position = Vector2i(furthest_x_tile,i)
		
		tiles[Vector2i(-1,i)] = tile_a
		tiles[Vector2i(furthest_x_tile,i)] = tile_b
	for i in range(0,furthest_x_tile):
		var tile_a : tile_resource = tile_resource.new()
		tile_a.tile_type = 1
		tile_a.occupied = false
		tile_a.tile_position = Vector2i(i,-1)
		
		var tile_b : tile_resource = tile_resource.new()
		tile_b.tile_type = 1
		tile_b.occupied = false
		tile_b.tile_position = Vector2i(i,highest_y_tile )
		
		tiles[Vector2i(i,-1)] = tile_a
		tiles[Vector2i(i,highest_y_tile )] = tile_b
