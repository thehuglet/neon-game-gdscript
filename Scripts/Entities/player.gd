class_name Player
extends CharacterBody2D

@export var neon_sprite: NeonSprite
@export var movement: Movement
@export var weapon_handler: WeaponHandler
@export var motion: Motion
@export var hurtbox: Hurtbox

var dash_iframe_end_timer: Timer
#var _hue_shift_amount: float = 0.0

func _ready() -> void:
	dash_iframe_end_timer = Timer.new()
	dash_iframe_end_timer.timeout.connect(_on_dash_iframe_end_timer_timeout)
	dash_iframe_end_timer.one_shot = true

	add_child(dash_iframe_end_timer)

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

func _on_dash_iframe_end_timer_timeout() -> void:
	hurtbox.enable_collision()

func _input(input: InputEvent) -> void:
	var movement_direction: Vector2 = Input.get_vector('left', 'right', 'up', 'down')

	movement.set_direction(movement_direction)

	if input.is_action_pressed('special'):
		weapon_handler.use_special(WeaponHandler.InputMode.SEMI_AUTO)
	if input.is_action_pressed('dash') && movement_direction != Vector2.ZERO:
		var dash_motion: Vector2 = movement_direction * 150
		var dash_speed: int = 30

		motion.apply(dash_motion, dash_speed)
		var dash_duration: float = motion.calculate_motion_duration(dash_motion, dash_speed)
		
		# end action is handled in [_on_dash_iframe_end_timer_timeout]
		hurtbox.disable_collision()
		dash_iframe_end_timer.start(dash_duration)

func _on_movement_updated(position_offset: Vector2) -> void:
	position += position_offset
