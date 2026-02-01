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
			match level_data.map_layout[y][x]:
				TileType.EMPTY:
					get_tree().root.add_child.call_deferred(draw_point(Vector3(x, 0.5, y), 0.1, Color.WEB_GRAY))
				TileType.BRICKS:
					get_tree().root.add_child.call_deferred(draw_point(Vector3(x, 0.5, y), 0.1, Color.RED))


func draw_point(pos: Vector3, radius: float = 0.05, color: Color = Color.WHITE_SMOKE) -> MeshInstance3D:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	var sphere_mesh: SphereMesh = SphereMesh.new()
	var material: ORMMaterial3D = ORMMaterial3D.new()
	
	mesh_instance.mesh = sphere_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	mesh_instance.position = pos
	
	sphere_mesh.radius = radius
	sphere_mesh.height = radius * 2.0
	sphere_mesh.material = material
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	return mesh_instance
