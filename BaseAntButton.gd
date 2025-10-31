class_name BaseAntButton extends Area2D

@export var button_id : int

var active : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_active(false)

func _set_active(val):
	active = val
	$Sprite2D.modulate.a = (1 if val else 0.5)
	get_tree().call_group("doors", "_update_active", button_id, val)
