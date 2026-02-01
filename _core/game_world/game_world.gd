class_name GameWorld
extends Node


@onready var map: Map = %Map
@onready var players: Node3D = %Players
@onready var enemies: Node3D = %Enemies
@onready var bullets: Node3D = %Bullets
@onready var powerups: Node3D = %Powerups


func _ready() -> void:
	map.load_level(1)
