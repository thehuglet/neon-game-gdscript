class_name HitContext

var target: CharacterBody2D:
	get: return _target
var damage_amount: int:
	get: return _damage_amount
	set(value): _damage_amount = value
var source_position: Vector2:
	get: return _source_position
	set(value): _source_position = value
var knockback_distance: float:
	get: return _knockback_distance
	set(value): _knockback_distance = value
var knockback_speed: float:
	get: return _knockback_speed
	set(value): _knockback_speed = value

var _target: CharacterBody2D
var _damage_amount: int
var _source_position: Vector2
var _knockback_distance: float
var _knockback_speed: float

func _init(target: CharacterBody2D) -> void:
	self._target = target
