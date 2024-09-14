class_name Player
extends CharacterBody2D

@export var neon_sprite: NeonSpriteComponent
@export var movement: MovementComponent
@export var weapon: WeaponComponent

func _process(delta: float) -> void:
	# Lerped visual rotation for smoother feel
	var angle_to_cursor: float = (get_global_mouse_position() - position).angle()
	neon_sprite.rotation = lerp_angle(neon_sprite.rotation, angle_to_cursor, 25 * delta)
	
	#neon_sprite.hue_shift_amount += 0.2 * delta

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('basic_attack'):
		weapon.fire_basic_attack()

func _input(input: InputEvent) -> void:
	movement.movement_direction = Input.get_vector('left', 'right', 'up', 'down')

func _on_movement_updated(position_offset: Vector2) -> void:
	position += position_offset
