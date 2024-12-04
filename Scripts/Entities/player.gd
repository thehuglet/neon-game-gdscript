class_name Player
extends Entity

@export var _player_weapon_handler: PlayerWeaponHandler
@export var _player_dash: PlayerDash
@export var _c_neon_sprite: NeonSprite
@export var _c_movement_controller: Movement

func _process(delta: float) -> void:
	# Lerped visual rotation for smoother feel
	var angle_to_cursor: float = (get_global_mouse_position() - position).angle()
	_c_neon_sprite.rotation = lerp_angle(_c_neon_sprite.rotation, angle_to_cursor, 25 * delta)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('basic_attack'):
		_player_weapon_handler.try_use_basic_attack(PlayerWeaponHandler.InputMode.AUTO)
	if Input.is_action_pressed('special'):
		_player_weapon_handler.try_use_special(PlayerWeaponHandler.InputMode.AUTO)
		# _weapon_handler.use_special(WeaponHandler.InputMode.FULL_AUTO)

func _input(input: InputEvent) -> void:
	var movement_direction: Vector2 = Input.get_vector('left', 'right', 'up', 'down')
	_c_movement_controller.set_direction(movement_direction)

	if input.is_action_pressed('basic_attack'):
		_player_weapon_handler.try_use_basic_attack(PlayerWeaponHandler.InputMode.SEMI)
	if input.is_action_pressed('special'):
		_player_weapon_handler.try_use_special(PlayerWeaponHandler.InputMode.SEMI)
	if input.is_action_pressed('dash') && movement_direction != Vector2.ZERO:
		_player_dash.start_dash(movement_direction)

func _on_movement_updated(position_offset: Vector2) -> void:
	position += position_offset
