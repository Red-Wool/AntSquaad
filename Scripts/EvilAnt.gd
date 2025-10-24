class_name EvilAnt extends Ant

func _connected_movement(movement : Vector2):
	velocity = -movement
	move_and_slide()
