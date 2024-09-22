class_name Player
extends CharacterBody2D

@export var neon_sprite: NeonSprite
@export var movement: Movement
@export var weapon_handler: WeaponHandler

#var _hue_shift_amount: float = 0.0

func _process(delta: float) -> void:
	# Lerped visual rotation for smoother feel
	var angle_to_cursor: float = (get_global_mouse_position() - position).angle()
	neon_sprite.rotation = lerp_angle(neon_sprite.rotation, angle_to_cursor, 25 * delta)
	
	#_hue_shift_amount += 0.3 * delta
	#neon_sprite.set_hue_shift(_hue_shift_amount)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('basic_attack'):
		weapon_handler.fire_basic_attack()
	if Input.is_action_pressed('special'):
		weapon_handler.use_special(WeaponHandler.InputMode.FULL_AUTO)

func _input(input: InputEvent) -> void:
	movement.movement_direction = Input.get_vector('left', 'right', 'up', 'down')

	if input.is_action_pressed('special'):
		weapon_handler.use_special(WeaponHandler.InputMode.SEMI_AUTO)
		

func _on_movement_updated(position_offset: Vector2) -> void:
	position += position_offset
