class_name AntDisconnector extends Area2D


func _on_body_entered(body):
	if body is PlayerAnt:
		body._disconnect_ants()
