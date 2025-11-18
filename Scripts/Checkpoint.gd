class_name Checkpoint extends Area2D

@onready var checkpoint_sfx : AudioStreamPlayer2D = $CheckpointSFX

func _on_body_entered(body):
	if body is PlayerAnt:
		CheckpointManager._set_checkpoint(get_tree().current_scene.name, global_position)
		checkpoint_sfx.play()
