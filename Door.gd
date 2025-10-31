extends StaticBody2D

@export var door_id : int
@export var inverted : bool = true

func _ready() -> void:
	_update_active(door_id, true)
	add_to_group("doors")
	pass # Replace with function body.

func _update_active(signal_id: int, val : bool):
	if (signal_id == door_id):
		var true_val = val if inverted else !val
		$Sprite2D.modulate.a = (1 if true_val else 0.5)
		$CollisionShape2D.set_deferred("disabled", !true_val)
		print_debug(val)
