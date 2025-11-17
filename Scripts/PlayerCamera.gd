class_name PlayerCamera extends Camera2D

@onready var player_follow : PlayerAnt = %PlayerAnt

@export var follow_speed : float
@export var zoom_speed : float
@export var zoom_distance : float

var shake_strength : Vector2
var shake_timer : float
var shake_time : float

var zoom_strength : float = 1.
var zoom_timer : float
var zoom_time : float

func _ready():
	await Engine.get_main_loop().process_frame
	CameraManager._set_main_camera(self)

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if !is_instance_valid(player_follow):
		return
	
	var follow : Vector2 = player_follow.global_position
	var furthest_point_distance : float = 0
	
	for ant : Ant in player_follow.connected_ants:
		if !is_instance_valid(ant):
			continue
		follow += ant.global_position
		
		if (global_position - ant.global_position).length() > furthest_point_distance:
			furthest_point_distance = (global_position - ant.global_position).length()
	
	follow /= 1 + player_follow.connected_ants.size()
	global_position = lerp(global_position, follow, delta * follow_speed)
	
	if shake_timer > 0:
		global_position += Vector2(randf_range(-shake_strength.x, shake_strength.x), randf_range(-shake_strength.y, shake_strength.y)) * (shake_timer/shake_time)
		shake_timer -= delta
	
	zoom = lerp(zoom, Vector2.ONE / max(1, furthest_point_distance / zoom_distance) * (.5 if Input.is_action_pressed("zoom") else 1.), delta * zoom_speed) * (zoom_strength if zoom_timer > 0 else 1.)
	zoom_timer -= delta

func _camera_shake(strength : Vector2, time : float):
	shake_strength = strength
	shake_timer = time
	shake_time = time

func _zoom_in(immediate_zoom : float, strength : float = 1., time : float = 0.):
	print(strength)
	zoom_strength = strength
	zoom_timer = time
	zoom_time = time
	zoom *= immediate_zoom
