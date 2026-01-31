class_name Map
extends Node3D


enum TileType {
	EMPTY,
	BRICKS,
	WALL,
	DEFENSE_POINT,
	PLAYER_SPAWN,
	ENEMY_SPAWN,
}
@onready var grid_map: GridMap = %GridMap


func load_level(level_data: LevelData) -> void:
	for y in range(level_data.map_layout.size()):
		for x in range(level_data.map_layout[y].size()):
			pass
