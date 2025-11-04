@icon("res://Art/THEANT.png")
class_name BaseAnt extends CharacterBody2D

@export var can_hold_object : bool

var is_holding_object : bool
var object_held : GrabbableObject

func _process(delta):
	if is_holding_object:
		object_held.global_position = global_position
		if Input.is_action_just_pressed("emit_signal"):
			_drop_object()

func _hold_object(object : GrabbableObject):
	is_holding_object = true
	object_held = object
	object._object_grabbed()

func _drop_object():
	is_holding_object = false
	object_held._object_dropped()

func _death():
	queue_free()
