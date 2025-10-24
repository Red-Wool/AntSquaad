class_name Ant extends CharacterBody2D

var is_player_connected : bool = false

var connected_ant : PlayerAnt

func _connect_ant(player : PlayerAnt):
	player._connect_ant(self)

func _connected_movement(movement : Vector2):
	velocity = movement
	move_and_slide()
