class_name Player
extends Entity

@export var _player_weapon_handler: PlayerWeaponHandler
@export var _player_dash: PlayerDash

@export_group('Neon Visuals')
@export var _neon_sprite: NeonSprite
@export var _neon_trail: NeonTrail

@export_group('Movement')
@export var _movement: Movement
@export var _movement_strategy: PlayerMovementStrategy

func _ready() -> void:
	_movement.set_movement_strategy(_movement_strategy)
	_movement.updated.connect(
		func(position_offset: Vector2) -> void:
			position += position_offset
	)

func _process(delta: float) -> void:
	# Lerped visual rotation for smoother feel
	var angle_to_cursor: float = (get_global_mouse_position() - position).angle()
	var new_rotation: float = lerp_angle(_neon_sprite.rotation, angle_to_cursor, 25 * delta)
	_neon_sprite.rotation = new_rotation
	_neon_trail.update_rotation(new_rotation)

func _physics_process(delta: float) -> void:
	_movement_strategy.set_facing_direction(Input.get_vector('left', 'right', 'up', 'down'))

	# full-auto weapon handling
	if Input.is_action_pressed('basic_attack'):
		_player_weapon_handler.try_use_basic_attack(PlayerWeaponHandler.InputMode.AUTO)
	if Input.is_action_pressed('special'):
		_player_weapon_handler.try_use_special(PlayerWeaponHandler.InputMode.AUTO)

func _input(input: InputEvent) -> void:
	var movement_direction: Vector2 = Input.get_vector('left', 'right', 'up', 'down')
	if input.is_action_pressed('dash') && movement_direction != Vector2.ZERO:
		_player_dash.start_dash(movement_direction)

	# semi-auto weapon handling
	if input.is_action_pressed('basic_attack'):
		_player_weapon_handler.try_use_basic_attack(PlayerWeaponHandler.InputMode.SEMI)
	if input.is_action_pressed('special'):
		_player_weapon_handler.try_use_special(PlayerWeaponHandler.InputMode.SEMI)
