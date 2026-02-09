class_name Projectile
extends Node3D


@export var speed: float = 100
@export var moving: bool = true
@onready var area_3d: Area3D = %Area3D
@onready var ray_0: RayCast3D = %Ray0
@onready var ray_1: RayCast3D = %Ray1
@onready var ray_2: RayCast3D = %Ray2
@onready var ray_3: RayCast3D = %Ray3



func _ready() -> void:
	area_3d.body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	if moving:
		global_position -= transform.basis.z * speed * delta


func _on_body_entered(body: Node3D) -> void:
	moving = false
	print(body.name)
	if body is GridMap:
		for ray: RayCast3D in [ray_0, ray_1, ray_2, ray_3]:
			_collide_ray(ray, body)
	queue_free()


func _collide_ray(ray: RayCast3D, grid_map: GridMap) -> void:
	if ray.is_colliding():
			print(transform.basis.z)
			var pos: Vector3i = grid_map.local_to_map(ray.get_collision_point())
			if int(transform.basis.z.z) > 0:
				pos.z -= 1
			if int(transform.basis.z.x) > 0:
				pos.x -= 1
			grid_map.set_cell_item(pos, GridMap.INVALID_CELL_ITEM)
