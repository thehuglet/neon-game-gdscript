class_name Weapon
extends Node2D

signal fired_basic_attack_pre
signal fired_basic_attack
signal fired_basic_attack_post
signal used_special_pre
signal used_special
signal used_special_post

var owner_ref: CharacterBody2D

func assign_owner(owner_ref: CharacterBody2D) -> void:
	self.owner_ref = owner_ref

func fire_basic_attack() -> void:
	fired_basic_attack_pre.emit()
	fired_basic_attack.emit()
	fired_basic_attack_post.emit()

func use_special() -> void:
	used_special_pre.emit()
	used_special.emit()
	used_special_post.emit()
