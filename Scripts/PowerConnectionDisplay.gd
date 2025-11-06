@tool
class_name PowerConnectionDisplay extends Line2D

@export var initial_plot_size : float

@export var input : Powerable
@export var output : Powerable

@export var update : bool:
	get:
		return update
	set (value):
		update = false
		print("gamming")
		if Engine.is_editor_hint():
			_create_display()

func _ready():
	_create_display()

func _create_display_power(i : Powerable, o : Powerable):
	input = i
	output = o
	_create_display()

func _create_display():
	if !is_instance_valid(input) or !is_instance_valid(output):
		return
	clear_points()
	add_point(input.position - global_position)
	
	var spot : Vector2 = output.global_position - input.global_position
	spot = input.global_position + Vector2(sign(spot.x) if spot.x > spot.y else 0., sign(spot.y) if spot.y > spot.x else 0.) * initial_plot_size
	add_point(spot-global_position)
	var final_spot : Vector2 = spot - output.global_position
	final_spot = output.global_position + Vector2(sign(final_spot.x) if final_spot.x > final_spot.y else 0., sign(final_spot.y) if final_spot.y > final_spot.x else 0.) * initial_plot_size
	
	add_point(spot + (final_spot - spot)*Vector2(1,0) - global_position)
	
	add_point(final_spot - global_position)
	add_point(output.position - global_position)
