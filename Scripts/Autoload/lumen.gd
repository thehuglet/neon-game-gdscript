extends Node

signal lumen_increased
signal lumen_decreased
signal lumen_updated(new_lumen_amount: int)
signal max_lumen_updated(new_max_lumen_amount: int)

var _lumen: int
var _max_lumen: int

func generate(amount: int) -> void:
	var increment: int = min(amount, _max_lumen - _lumen)
	_lumen += increment

	if increment != 0:
		lumen_increased.emit()
		lumen_updated.emit(_lumen)

func drain(amount: int) -> void:
	var decrement: int = min(amount, _lumen)
	_lumen -= decrement

	if decrement != 0:
		lumen_decreased.emit()
		lumen_updated.emit(_lumen)

func get_amount() -> int:
	return _lumen

func set_max(amount: int) -> void:
	_max_lumen = amount
