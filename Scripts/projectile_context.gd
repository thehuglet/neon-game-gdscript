class_name ProjectileContext

var projectile_scene: PackedScene
var spawn_position: Vector2
var facing_direction: Vector2

func _init(
	_projectile_scene: PackedScene,
	_spawn_position: Vector2,
	_facing_direction: Vector2,
) -> void:
	self.projectile_scene = _projectile_scene
	self.spawn_position = _spawn_position
	self.facing_direction = _facing_direction
