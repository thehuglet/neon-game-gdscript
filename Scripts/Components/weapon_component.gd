class_name WeaponComponent
extends Node2D

@export var owner_ref: CharacterBody2D

enum WeaponSlot {
	SLOT_0,
	SLOT_1,
}

var _weapons: Array[Weapon] = [null, null]
var _selected_weapon: Weapon
#var _selected_weapon_slot: int = 0

func _ready() -> void:
	# TODO: temp weapon debug code, remove later
	load_weapon(preload('res://Scenes/Weapons/NeonBlaster/neon_blaster.tscn') as PackedScene, WeaponSlot.SLOT_0)
	
	select_weapon_slot(WeaponSlot.SLOT_0)

func fire_basic_attack() -> void:
	# TODO: implement fire rate
	_selected_weapon.fire_basic_attack()

func use_special() -> void:
	_selected_weapon.use_special()

func load_weapon(weapon: PackedScene, slot: WeaponSlot) -> void:
	var inst := weapon.instantiate() as Weapon
	inst.assign_owner(owner_ref)
	
	_weapons[slot] = inst
	add_child(_weapons[slot])

func select_weapon_slot(slot: WeaponSlot) -> void:
	if slot > len(_weapons):
		return
	
	#_selected_weapon_slot = slot
	_selected_weapon = _weapons[slot]
