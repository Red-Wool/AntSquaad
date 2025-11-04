class_name GrabbableObject extends Area2D

@onready var collision : CollisionShape2D = $Collision

func _collision(body : Node2D):
	if body is BaseAnt:
		print("Gaming")
		body._hold_object(self)

func _object_grabbed():
	pass

func _object_dropped():
	pass

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_collision(body)
