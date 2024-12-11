class_name Sentinel
extends Entity

var _target_position: Vector2
var _movement_speed: int = 200

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass



# var _points: Array[Vector2] = []
# var _time: float = 0.0

# func _ready() -> void:
# 	add_bezier_point(position + Vector2(100, 50))
# 	add_bezier_point(position + Vector2(30, -30))
# 	add_bezier_point(position + Vector2(-50, 70))

# func _physics_process(delta: float) -> void:
# 	# ($C_NeonSprite as NeonSprite).position = bezier(_time)
# 	position = bezier(_time)
# 	_time += delta
# 	if _time >= 1.0:
# 		_time = 0.0./
	
# func bezier(t: float) -> Vector2:
# 	var q0: Vector2 = _points[0].lerp(_points[1], t)
# 	var q1: Vector2 = _points[1].lerp(_points[2], t)
# 	return q0.lerp(q1, t)

# func add_bezier_point(position: Vector2) -> void:
# 	if _points.size() >= 3:
# 		_points.pop_front()

# 	_points.append(position)
