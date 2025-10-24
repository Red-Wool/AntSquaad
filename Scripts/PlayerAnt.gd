class_name PlayerAnt extends CharacterBody2D

@export var speed : float
@export var max_speed_range : float

@onready var ant_signal_prefab : PackedScene = preload("res://Prefabs/ant_signal.tscn")

var move_difference : Vector2

signal ant_movement(movement : Vector2)

func _physics_process(delta):
	var move = get_local_mouse_position()
	move = move.normalized() * speed * min(move.length()/max_speed_range, 1.)
	velocity = move * delta
	
	move_and_slide()
	
	ant_movement.emit((global_position - move_difference)/delta)
	move_difference = global_position
	
	
	if Input.is_action_just_pressed("emit_signal"):
		var ant_signal : AntSignal = ant_signal_prefab.instantiate()
		add_sibling(ant_signal)
		ant_signal.global_position = global_position
		ant_signal._trigger_signal(self)

func _disconnect_ants():
	for connection in ant_movement.get_connections():
		ant_movement.disconnect(connection.callable)

func _death():
	#death!
	pass
