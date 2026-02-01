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
@onready var json_reader: JSONReaderComponent = %JsonReaderComponent


func load_level(id: int) -> void:
	var data: Dictionary = json_reader.read_from_folder("level_%s.json" % id)
	var level_data: LevelData = LevelData.new()
	level_data.id = data.id
	level_data.name = data.name
	for row_data in data.map_layout:
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


func _spawn_bricks(pos: Vector3i) -> void:
	for z in range(4):
		for x in range(4):
			var current_pos: Vector3i = Vector3i(pos.x + x, 0, pos.z + z)
			grid_map.set_cell_item(current_pos, 0)


func _spawn_walls(pos: Vector3i) -> void:
	grid_map.set_cell_item(pos, 1)

#func draw_point(pos: Vector3, radius: float = 0.05, color: Color = Color.WHITE_SMOKE) -> MeshInstance3D:
	#var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	#var sphere_mesh: SphereMesh = SphereMesh.new()
	#var material: ORMMaterial3D = ORMMaterial3D.new()
	#
	#mesh_instance.mesh = sphere_mesh
	#mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	#mesh_instance.position = pos
	#
	#sphere_mesh.radius = radius
	#sphere_mesh.height = radius * 2.0
	#sphere_mesh.material = material
	#
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = color
	#
	#return mesh_instance
