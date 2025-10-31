class_name PlayerAnt extends BaseAnt

@export var speed : float
@export var max_speed_range : float

@onready var ant_signal_prefab : PackedScene = preload("res://Prefabs/ant_signal.tscn")

var move_difference : Vector2

var connected_ants : Array[Ant]

signal ant_movement(movement : Vector2)

func _process(delta):
	super(delta)

func _physics_process(delta):
	
	#Mouse Movement
	#var move = get_local_mouse_position()
	#move = move.normalized() * speed * min(move.length()/max_speed_range, 1.)
	
	#WASD
	var move = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	move = move.normalized() * speed
	
	velocity = move * delta
	
	move_and_slide()
	
	ant_movement.emit((global_position - move_difference)/delta)
	move_difference = global_position
	
	
	if Input.is_action_just_pressed("emit_signal"):
		var ant_signal : AntSignal = ant_signal_prefab.instantiate()
		add_sibling(ant_signal)
		ant_signal.global_position = global_position
		ant_signal._trigger_signal(self, 200, .5)

func _connect_ant(ant : Ant):
	if !ant_movement.is_connected(ant._connected_movement):
		ant_movement.connect(ant._connected_movement)
		connected_ants.append(ant)

func _disconnect_ants():
	for connection in ant_movement.get_connections():
		ant_movement.disconnect(connection.callable)
	connected_ants.clear()
