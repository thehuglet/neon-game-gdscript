class_name ProjectileContext

var projectile_scene: PackedScene:
	get: return _projectile_scene
var spawn_position: Vector2:
	get: return _spawn_position
var facing_direction: Vector2:
	get: return _facing_direction

var _projectile_scene: PackedScene
var _spawn_position: Vector2
var _facing_direction: Vector2

func _init(projectile_scene: PackedScene, spawn_position: Vector2, facing_direction: Vector2) -> void:
	_projectile_scene = projectile_scene
	_spawn_position = spawn_position
	_facing_direction = facing_direction
