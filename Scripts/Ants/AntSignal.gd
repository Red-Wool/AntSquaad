class_name AntSignal extends Area2D

@onready var collision : CollisionShape2D = $Collision
@onready var sprite : Sprite2D = $Visual

var owner_ant : PlayerAnt

func _trigger_signal(ant : PlayerAnt, size : float = 200., time : float = 1.):
	owner_ant = ant
	var tween : Tween = get_tree().create_tween().set_parallel()
	collision.shape.radius = 10
	tween.tween_property(collision.shape, "radius", size, time)
	sprite.scale = Vector2.ONE * .16
	tween.tween_property(sprite, "scale", Vector2.ONE * .16 * (size*.1), time)
	
	await get_tree().create_timer(time).timeout
	collision.disabled = true
	get_tree().create_tween().tween_property(sprite.material, "shader_parameter/alpha", 0, .1)
	await get_tree().create_timer(.1).timeout
	queue_free()

func _on_body_entered(body):
	if !is_instance_valid(owner_ant):
		return
	
	if body is Ant:
		body._connect_ant(owner_ant)
	pass # Replace with function body.
