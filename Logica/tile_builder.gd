extends Node3D

var tilemap : TileMapLayer
@export var tile_size : Vector2 = Vector2(14.0, 30.0)

var test_tile = preload("res://Escenas/Tiles/road_00.tscn")

var TILES : Dictionary = {
	"start" : preload("res://Escenas/Tiles/start.tscn"),
	"road_00" : preload("res://Escenas/Tiles/road_00.tscn"),
	"road_01" : preload("res://Escenas/Tiles/road_01.tscn"),
	"road_02" : preload("res://Escenas/Tiles/road_02.tscn"),
	"road_03" : preload("res://Escenas/Tiles/road_03.tscn"),
	"road_04" : preload("res://Escenas/Tiles/road_04.tscn"),
	"finish" : preload("res://Escenas/Tiles/finish.tscn")
}

func _ready() -> void:
	tilemap = get_child(0)
	for coord in tilemap.get_used_cells():
		var tile = tilemap.get_cell_tile_data(coord)
		var inst_name = tile.get_custom_data("name")
		var inst = TILES[inst_name].instantiate() 
		inst.position.z = float(coord.y + 1) * tile_size.y
		inst.position.x = float(coord.x) * tile_size.x
		add_child(inst)
