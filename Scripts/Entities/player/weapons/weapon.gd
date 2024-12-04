class_name Weapon
extends Node2D

@export_enum('SEMI', 'AUTO') var basic_attack_input_mode: int
@export var _basic_attack_fire_rate: float = 1.0 
@export_enum('SEMI', 'AUTO') var special_input_mode: int
@export var _special_fire_rate: float = 0.5

@onready var _basic_attack_use_interval: float = 1.0 / _basic_attack_fire_rate
@onready var _special_use_interval: float = 1.0 / _special_fire_rate
var _basic_attack_use_cooldown: float = 0.0
var _special_use_cooldown: float = 0.0
var _parent_entity: CharacterBody2D

## Override me!
func _on_use_basic_attack() -> void:
	pass

# Override me!
func _on_use_special() -> void:
	pass

func _physics_process(delta: float) -> void:
	if _is_basic_attack_on_cooldown():
		_basic_attack_use_cooldown = max(_basic_attack_use_cooldown - delta, 0.0)
	if _is_special_on_cooldown():
		_special_use_cooldown = max(_special_use_cooldown - delta, 0.0)

func use_basic_attack() -> void:
	if !_is_basic_attack_on_cooldown():
		_basic_attack_use_cooldown = _basic_attack_use_interval
		_on_use_basic_attack()

func use_special() -> void:
	if !_is_special_on_cooldown():
		_special_use_cooldown = _special_use_interval
		_on_use_special()

func set_parent_entity(parent_entity: CharacterBody2D) -> void:
	_parent_entity = parent_entity

func get_parent_entity() -> CharacterBody2D:
	return _parent_entity

func _is_basic_attack_on_cooldown() -> bool:
	return _basic_attack_use_cooldown > 0.0

func _is_special_on_cooldown() -> bool:
	return _special_use_cooldown > 0.0
