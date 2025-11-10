extends Node
var main_camera : PlayerCamera

func _set_main_camera(cam : PlayerCamera):
	main_camera = cam

func _get_main_camera() -> PlayerCamera:
	return main_camera if is_instance_valid(main_camera) else null

func _screen_shake(strength : Vector2, time : float):
	if is_instance_valid(main_camera):
		main_camera._camera_shake(strength, time)

func _zoom_in(immediate_zoom : float, strength : float = 1., time : float = 0.):
	if is_instance_valid(main_camera):
		main_camera._zoom_in(immediate_zoom, strength, time)
