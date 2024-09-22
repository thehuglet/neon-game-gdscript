class_name Projectile
extends Area2D

@export var damage: int = 1
@export var speed: int = 800
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	monitorable = false

func _process(delta: float) -> void:
	position += direction * speed * delta
