extends Powerable

func _process_input():
	var open = inputs.find(true) != -1
	$Sprite2D.modulate.a = (1 if !open else 0.5)
	$CollisionShape2D.set_deferred("disabled", open)
