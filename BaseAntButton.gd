class_name BaseAntButton extends Area2D

@export var button_id : int

var active : bool
var self_active : bool

var count : int = 0

var connected_buttons : Array[BaseAntButton]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_active(false)
	_set_self_active(false)
	add_to_group("buttons")
	get_tree().call_deferred("call_group", "buttons", "_connect_button", self, button_id);

func _connect_button(other_button, other_id):
	if (other_button != self && other_id == button_id):
		connected_buttons.append(other_button)

func _on_body_entered(body):
	if body is BaseAnt or body is GrabbableFile:
		if (count == 0):
			_set_self_active(true)
		count += 1

func _on_body_exited(body):
	if body is BaseAnt or body is GrabbableFile:
		count -= 1
		if (count == 0):
			_set_self_active(false)

func _set_self_active(val):
	self_active = val;
	$Sprite2D. flip_v = val
	var full_update = true
	for button in connected_buttons:
		if !button.self_active:
			full_update = false
	if full_update:
		_on_full_press() if val else _on_full_unpress()

func _on_full_press():
	pass

func _on_full_unpress():
	pass

func _set_active(val):
	active = val
	$Sprite2D.modulate.a = (1 if val else 0.5)
	get_tree().call_group("doors", "_update_active", button_id, val)
	for button in connected_buttons:
		button.get_node("Sprite2D").modulate.a = (1 if val else 0.5)
