class_name GrabbableFile extends GrabbableObject


func _collision(body : Node2D):
	print("Grab!")
	super(body)
	#if true:
	#	collision.disabled = true

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_collision(body)
