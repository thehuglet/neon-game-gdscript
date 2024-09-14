class_name Bullet
extends Area2D

signal post_ready
signal post_process(delta: float)
signal post_physics_process(delta: float)
signal hit
signal died

@export var damage: int = 1
@export var speed: int = 600
@export var max_range: int = 2000

var facing_direction: Vector2
var _travelled_distance: float = 0

func _ready() -> void:
	monitorable = false
	collision_layer = 0
	
	body_entered.connect(_on_body_entered)
	
	post_ready.emit()

func _physics_process(delta: float) -> void:
	post_physics_process.emit(delta)

func _process(delta: float) -> void:
	# Forward linear movement
	var distance: float = speed * delta
	var motion: Vector2 = facing_direction * distance
	position += motion
	
	_travelled_distance += distance
	if _travelled_distance > max_range:
		queue_free()
	
	post_process.emit(delta)

func _on_body_entered(body: CharacterBody2D) -> void:
	var ctx: HitContext = HitContext.new(body)
	ctx.damage = damage
	SignalBus.entity_hit.emit(ctx)
	hit.emit()
	died.emit()
	
	queue_free()
