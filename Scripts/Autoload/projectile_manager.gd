extends Node

const SCREEN_SIZE_BUFFER: int = 100

var active_projectiles: Array[Projectile] = []
var debug_label: Label

func _ready() -> void:
	var d := Label.new()
	d.position = Vector2(30, 30)

	debug_label = d
	add_child(debug_label)

func _physics_process(delta: float) -> void:
	for i in range(active_projectiles.size() - 1, -1, -1):
		var projectile: Projectile = active_projectiles[i]
		
		# Fallback in case the projectile gets freed elsewhere
		if projectile == null:
			active_projectiles.remove_at(i)
			continue
		
		if _is_out_of_screen_bounds(projectile):
			projectile.queue_free()
			active_projectiles.remove_at(i)

func spawn_projectile(ctx: ProjectileContext) -> void:
	var projectile: Projectile = ctx.projectile_scene.instantiate() as Projectile

	projectile.position = ctx.spawn_position
	projectile.direction = ctx.facing_direction
	projectile.rotation = ctx.facing_direction.angle()

	add_child(projectile)
	active_projectiles.append(projectile)

func _is_out_of_screen_bounds(projectile: Projectile) -> bool:
	var screen_size: Rect2 = get_viewport().get_visible_rect().grow(SCREEN_SIZE_BUFFER)
	return !screen_size.has_point(projectile.position)