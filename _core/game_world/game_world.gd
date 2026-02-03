class_name GameWorld
extends Node


@onready var map: Map = %Map
@onready var players: Node3D = %Players
@onready var enemies: Node3D = %Enemies
@onready var bullets: Node3D = %Bullets
@onready var powerups: Node3D = %Powerups
@onready var defense_objectives: Node3D = %DefenseObjectives


func _ready() -> void:
	map.defense_objective_parent = defense_objectives
	map.load_level(0)
