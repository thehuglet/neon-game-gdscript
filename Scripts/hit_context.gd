class_name HitContext

var target: CharacterBody2D
var damage: int
var source_position: Vector2
var knockback_distance: float
var knockback_speed: float

func _init(_target: CharacterBody2D) -> void:
	target = _target
