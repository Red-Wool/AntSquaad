class_name Ant extends BaseAnt

var is_player_connected : bool = false

var connected_ant : PlayerAnt

func _connect_ant(player : PlayerAnt):
	is_player_connected = true
	connected_ant = player
	player._connect_ant(self)

func _connected_movement(movement : Vector2):
	velocity = movement
	move_and_slide()

func _death():
	print("death")
	if is_player_connected:
		connected_ant._connected_ant_death(self)
	super()
