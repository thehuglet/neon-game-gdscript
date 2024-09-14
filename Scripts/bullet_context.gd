class_name BulletContext
extends Node

var bullet: PackedScene
var spawn_position: Vector2
var facing_direction: Vector2

func _init(bullet: PackedScene, spawn_position: Vector2) -> void:
	self.bullet = bullet
	self.spawn_position = spawn_position



#var target: CharacterBody2D
#var damage: int
#var source_position: Vector2
#var knockback_distance: float
#var knockback_speed: float
#
#func _init(_target: CharacterBody2D) -> void:
	#target = _target
