class_name Ant extends CharacterBody2D

var is_player_connected : bool = false

var connected_ant : PlayerAnt

func _connect_ant(player : PlayerAnt):
	if !player.ant_movement.is_connected(_connected_movement):
		player.ant_movement.connect(_connected_movement)

func _connected_movement(movement : Vector2):
	velocity = movement
	move_and_slide()
