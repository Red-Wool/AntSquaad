class_name GrabbableFile extends GrabbableObject

@onready var grab_sfx : AudioStreamPlayer2D = $FileGrabSFX
@onready var drop_sfx : AudioStreamPlayer2D = $FileDropSFX

func _collision(body : Node2D):
	super(body)
	#if true:
	#	collision.disabled = true

func _object_grabbed():
	grab_sfx.play()

func _object_dropped():
	drop_sfx.play()


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_collision(body)
