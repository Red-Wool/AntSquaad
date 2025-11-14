class_name PlayerAnt extends BaseAnt

@export var speed : float
@export var max_speed_range : float

@onready var ant_signal_prefab : PackedScene = preload("res://Prefabs/Hazards/ant_signal.tscn")
@onready var ant_connection_prefab : PackedScene = preload("res://Prefabs/ant_connector.tscn")

@onready var ant_connection_visual : CanvasGroup = $AntConnectionVisual
@onready var ant_connection_hexagon : Sprite2D = $AntConnectionVisual/Hexagon

@onready var ant_signal_sfx : AudioStreamPlayer2D = $AntSignalSFX
@onready var ant_connect_sfx : AudioStreamPlayer2D = $AntConnectSFX
@onready var ant_disconnect_sfx : AudioStreamPlayer2D = $AntDisconnectSFX
@onready var ant_real_disconnect_sfx : AudioStreamPlayer2D = $AntRealDisconnectSFX

@onready var fun_mode_music : AudioStreamPlayer2D = $FunModeMusic

var move_difference : Vector2

var connected_ants : Array[Ant]

var disconnector_count : int = 0
var move_timer : float

signal ant_movement(movement : Vector2)

func _process(delta):
	super(delta)
	if Input.is_action_just_pressed("fun"):
		fun_mode_music.play()
	elif Input.is_action_just_released("fun"):
		fun_mode_music.stop()

func _physics_process(delta):
	
	#Mouse Movement
	#var move = get_local_mouse_position()
	#move = move.normalized() * speed * min(move.length()/max_speed_range, 1.)
	
	#WASD
	var move = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	move = move.normalized() * speed
	
	ant_connection_hexagon.rotation_degrees += 60 * delta
	
	if move != Vector2.ZERO:
		animation.play("walk")
		visual.flip_h = move.x < 0
		move_timer += delta
	else:
		animation.stop()
		move_timer = lerp(move_timer, 0., delta*5.)
	ant_connection_visual.material.set_shader_parameter("moveTimer", move_timer*400.)
	
	if Input.is_action_pressed("fun"):
		move *= 2
	
	velocity = move * delta
	
	move_and_slide()
	
	ant_movement.emit((global_position - move_difference)/delta)
	move_difference = global_position
	
	
	if Input.is_action_just_pressed("emit_signal"):
		var ant_signal : AntSignal = ant_signal_prefab.instantiate()
		add_sibling(ant_signal)
		ant_signal.global_position = global_position
		ant_signal._trigger_signal(self, 200, .5)
		
		ant_signal_sfx.play()
		CameraManager._zoom_in(.99)

func _connect_ant(ant : Ant):
	if !ant_movement.is_connected(ant._connected_movement):
		ant_movement.connect(ant._connected_movement)
		connected_ants.append(ant)
		
		var ant_connector : AntConnector = ant_connection_prefab.instantiate()
		ant_connection_visual.add_child(ant_connector)
		ant_connector.global_position = global_position
		ant_connector.connected_ant = ant
		
		ant_connect_sfx.play()
		
		ant_connection_hexagon.scale = Vector2.ZERO
		get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC).tween_property(ant_connection_hexagon, "scale", Vector2.ONE, 1)

func _connected_ant_death(ant : Ant):
	var index : int = connected_ants.find(ant)
	if index != -1:
		for connection in ant_movement.get_connections():
			if ant_movement.is_connected(connected_ants[index]._connected_movement):
				ant_movement.disconnect(connected_ants[index]._connected_movement)
				break
		connected_ants.remove_at(index)
		ant_real_disconnect_sfx.play()
		CameraManager._screen_shake(Vector2(15,15), .4)
	
	if connected_ants.size() == 0:
		get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK).tween_property(ant_connection_hexagon, "scale", Vector2.ZERO, .5)

func _disconnect_ants():
	if ant_connection_visual.get_children().size() > 0:
		ant_real_disconnect_sfx.play()
		CameraManager._screen_shake(Vector2(10,0), .3)
	
	for connection in ant_movement.get_connections():
		ant_movement.disconnect(connection.callable)
	
	for ant_visual in ant_connection_visual.get_children():
		if ant_visual is AntConnector:
			ant_visual._death()
	connected_ants.clear()
	ant_disconnect_sfx.play()
	get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK).tween_property(ant_connection_hexagon, "scale", Vector2.ZERO, .5)

func _death():
	_disconnect_ants()
	super()
