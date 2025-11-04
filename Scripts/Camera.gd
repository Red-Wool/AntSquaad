class_name CameraScript extends Camera2D

@onready var player_follow : PlayerAnt = %PlayerAnt

@export var follow_speed : float
@export var zoom_speed : float
@export var zoom_distance : float

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if !is_instance_valid(player_follow):
		return
	
	var follow : Vector2 = player_follow.position
	var furthest_point_distance : float = 0
	
	for ant : Ant in player_follow.connected_ants:
		if !is_instance_valid(ant):
			continue
		follow += ant.position
		
		if (position - ant.position).length() > furthest_point_distance:
			furthest_point_distance = (position - ant.position).length()
	
	follow /= 1 + player_follow.connected_ants.size()
	position = lerp(position, follow, delta * follow_speed)
	zoom = lerp(zoom, Vector2.ONE / max(1, furthest_point_distance / zoom_distance) , delta * zoom_speed)
