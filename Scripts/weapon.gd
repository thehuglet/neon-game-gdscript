class_name Weapon
extends Node2D

signal fired_basic_attack
signal used_special

@export_enum('SEMI_AUTO', 'FULL_AUTO') var special_input_mode: int
@export var fire_rate: float = 1.0:
	get:
		return fire_rate
	set(value):
		fire_rate = value
		_basic_attack_interval = 1.0 / value

var owner_ref: CharacterBody2D

var is_basic_attack_cooldown: bool = false
var _basic_attack_cooldown: float = 0.0
@onready var _basic_attack_interval: float = 1.0 / fire_rate

func _physics_process(delta: float) -> void:
	is_basic_attack_cooldown = _basic_attack_cooldown > 0.0

	if is_basic_attack_cooldown:
		_basic_attack_cooldown = max(_basic_attack_cooldown - delta, 0.0)

func assign_owner(owner_ref: CharacterBody2D) -> void:
	self.owner_ref = owner_ref

func fire_basic_attack() -> void:
	if !is_basic_attack_cooldown:
		_basic_attack_cooldown = _basic_attack_interval
		fired_basic_attack.emit()

func use_special() -> void:
	used_special.emit()
