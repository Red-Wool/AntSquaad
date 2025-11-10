class_name PlayerAnt extends BaseAnt

@export var speed : float
@export var max_speed_range : float

@onready var ant_signal_prefab : PackedScene = preload("res://Prefabs/Hazards/ant_signal.tscn")
@onready var ant_connection_prefab : PackedScene = preload("res://Prefabs/ant_connector.tscn")

@onready var ant_connection_visual : CanvasGroup = $AntConnectionVisual

@onready var ant_signal_sfx : AudioStreamPlayer2D = $AntSignalSFX
@onready var ant_connect_sfx : AudioStreamPlayer2D = $AntConnectSFX
@onready var ant_disconnect_sfx : AudioStreamPlayer2D = $AntDisconnectSFX
@onready var ant_real_disconnect_sfx : AudioStreamPlayer2D = $AntRealDisconnectSFX

@onready var fun_mode_music : AudioStreamPlayer2D = $FunModeMusic

var move_difference : Vector2

var connected_ants : Array[Ant]


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

func _disconnect_ants():
	if ant_connection_visual.get_children().size() > 0:
		ant_real_disconnect_sfx.play()
		CameraManager._screen_shake(Vector2(10,0), .3)
	
	for connection in ant_movement.get_connections():
		ant_movement.disconnect(connection.callable)
	
	for visual in ant_connection_visual.get_children():
		visual._death()
	connected_ants.clear()
	ant_disconnect_sfx.play()

func _death():
	_disconnect_ants()
	super()
