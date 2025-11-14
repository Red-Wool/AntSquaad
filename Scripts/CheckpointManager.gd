extends Node

var checkpoint_scene_name : String
var checkpoint_location : Vector2

func _valid_checkpoint(scene_name : String) -> bool:
	if scene_name == checkpoint_scene_name:
		return true
	return false

func _set_checkpoint(scene_name : String, point : Vector2):
	checkpoint_scene_name = scene_name
	checkpoint_location = point

func _get_checkpoint() -> Vector2:
	return checkpoint_location
