class_name AxisAnt extends Ant

@export var speed_multiplier : Vector2

func _connected_movement(movement : Vector2):
	velocity = movement * speed_multiplier
	move_and_slide()
