extends Powerable

@onready var lock_sprite : Texture = preload("res://Art/FIREWALL_LOCKED.png")
@onready var unlock_sprite : Texture = preload("res://Art/FIREWALL_UNLOCK.png")

@onready var open_sfx : AudioStreamPlayer2D = $OpenDoorSFX
@onready var close_sfx : AudioStreamPlayer2D = $CloseDoorSFX

func _process_input():
	var open = inputs.find(true) != -1
	$Sprite2D.modulate.a = (1 if !open else 0.5)
	$Sprite2D.texture = (lock_sprite if !open else unlock_sprite)
	$CollisionShape2D.set_deferred("disabled", open)
	
	if open:
		open_sfx.play()
	else:
		close_sfx.play()
