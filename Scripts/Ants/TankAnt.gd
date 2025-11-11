class_name TankAnt extends Ant

func _connected_movement(movement : Vector2):
	var rot = sign(movement.x) * 4
	var move = movement.y
	rotation_degrees += rot;
	velocity = Vector2.from_angle(rotation) * -move;
	move_and_slide()
	
	if movement != Vector2.ZERO:
		animation.play("walk")
	else:
		animation.stop()
