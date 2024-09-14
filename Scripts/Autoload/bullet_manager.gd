extends Node

func spawn_bullet(ctx: BulletContext) -> void:
	var inst := ctx.bullet.instantiate() as Bullet
	inst.position = ctx.spawn_position
	inst.facing_direction = ctx.facing_direction
	inst.rotation = ctx.facing_direction.angle()
	add_child(inst)


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
