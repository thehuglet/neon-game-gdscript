class_name PlayerWeaponHandler
extends Node

enum InputMode {
	SEMI,
	AUTO,
}

@export var _weapon_0: Weapon
# @export var _weapon_1: Weapon
@export var _parent_entity: CharacterBody2D

func _ready() -> void:
	# Warning: this has to run every time a new weapon is loaded!!
	_weapon_0.set_parent_entity(_parent_entity)

func _process(delta: float) -> void:
	pass

func try_use_basic_attack(input_mode: InputMode) -> void:
	if _weapon_0.basic_attack_input_mode == input_mode:
		_weapon_0.use_basic_attack()

func try_use_special(input_mode: InputMode) -> void:
	if _weapon_0.special_input_mode == input_mode:
		_weapon_0.use_special()
