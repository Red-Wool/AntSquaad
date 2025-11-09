class_name AntConnector extends Line2D

@export var connection_points : int = 10
var connected_ant 

var mid_point : Vector2
var end_point : Vector2

@onready var square : Sprite2D = $Square
@onready var error : Sprite2D = $WRONG

var dead : bool

func _bezier(p1 : Vector2, p2 : Vector2, p3 : Vector2, t : float) -> Vector2:
	return lerp(lerp(p1, p2, t), lerp(p2, p3, t), t)

func _ready():
	mid_point = global_position
	end_point = global_position
	clear_points()
	for i in connection_points+1:
		add_point(Vector2.ZERO)
	
	square.scale = Vector2.ZERO
	get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC).tween_property(square, "scale", Vector2.ONE, 1)

func _process(delta):
	if is_instance_valid(connected_ant) and !dead:
		square.rotation_degrees += 180 * delta
		square.global_position = connected_ant.global_position
		
		end_point = lerp(end_point, (connected_ant.global_position), delta*10.)
		mid_point = lerp(mid_point, global_position + (end_point - global_position)*.5, delta*2.)
		
		#print(str(end_point) + " " + str(mid_point))
		
		for i in connection_points:
			set_point_position(i+1, _bezier(Vector2.ZERO, mid_point - global_position, end_point - global_position, (i+1.)/(connection_points)))
		#set_point_position(1, lerp(get_point_position((1)), (connected_ant.global_position - global_position)*.5, delta * 1.))
		#set_point_position(2, lerp(get_point_position((2)), connected_ant.global_position - global_position, delta * 20.))
	else:
		_death()

func _death():
	if dead:
		return
	dead = true
	if is_instance_valid(connected_ant):
		error.global_position = global_position + (connected_ant.global_position - global_position)*.5
	else:
		error.global_position = mid_point
	error.visible = true
	
	await get_tree().create_timer(.5).timeout
	queue_free()
