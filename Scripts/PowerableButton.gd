class_name PowerableButton extends Powerable

@onready var button_on_sfx : AudioStreamPlayer2D = $ButtonOnSFX
@onready var button_off_sfx : AudioStreamPlayer2D = $ButtonOffSFX

var count = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	_add_input()

func _on_body_entered(body):
	if body is BaseAnt or body is GrabbableFile:
		if (count == 0):
			_update_pressed(true)
		count += 1

func _on_body_exited(body):
	if body is BaseAnt or body is GrabbableFile:
		count -= 1
		if (count == 0):
			_update_pressed(false)

func _update_pressed(val):
	if val:
		button_on_sfx.play()
	else:
		button_off_sfx.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_input():
	var on = inputs.find(true) != -1
	$AnimatedSprite2D.animation = &"on" if on else &"off"
	_set_output(on)
