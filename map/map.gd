class_name Map
extends Node3D


enum TileType {
	EMPTY,
	BRICKS,
	WALL,
	DEFENSE_OBJECTIVE,
	PLAYER_SPAWN,
	ENEMY_SPAWN,
}
const DEFENSE_OBJECTIVE: PackedScene = preload("uid://ce13h7iwwirtk")
@onready var grid_map: GridMap = %GridMap
@onready var json_reader: JSONReaderComponent = %JsonReaderComponent
var defense_objective_parent: Node3D


func load_level(id: int) -> void:
	var data: Dictionary = json_reader.read_from_folder("level_%s.json" % id)
	var level_data: LevelData = LevelData.new()
	
	level_data.id = data.id
	level_data.name = data.name
	var layout: Array = data.map_layout["easy"]
	for row_data in layout:
		var row_array: Array = []
		for column_data in row_data:
			row_array.append(int(column_data))
		level_data.map_layout.append(row_array)
	
	_set_level(level_data)


func _set_level(level_data: LevelData) -> void:
	for y in range(level_data.map_layout.size()):
		for x in range(level_data.map_layout[y].size()):
			var placement_pos: Vector3i = grid_map.local_to_map(Vector3(x, 0.0, y))
			match level_data.map_layout[y][x]:
				TileType.BRICKS:
					_spawn_bricks(placement_pos)
				TileType.WALL:
					_spawn_walls(placement_pos)
				TileType.DEFENSE_OBJECTIVE:
					_spawn_defense_objective(Vector3(x, 0.0, y))


func _spawn_bricks(pos: Vector3i) -> void:
	for z in range(4):
		for x in range(4):
			var current_pos: Vector3i = Vector3i(pos.x + x, 0, pos.z + z)
			grid_map.set_cell_item(current_pos, 0)


func _spawn_walls(pos: Vector3i) -> void:
	grid_map.set_cell_item(pos, 1)


func _spawn_defense_objective(pos: Vector3) -> void:
	if defense_objective_parent == null:
		assert(false, "Defense objective parent not set.")
	var defense_objective: DefenseObjective = DEFENSE_OBJECTIVE.instantiate()
	defense_objective_parent.add_child(defense_objective)
	defense_objective.global_position = pos
