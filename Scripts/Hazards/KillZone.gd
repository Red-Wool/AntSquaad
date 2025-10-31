class_name KillZone extends Area2D
@export var disable_after_hit: bool = true

func _ready() -> void: 
	monitoring = true
	#body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void: 
	print("enter")
	if body is BaseAnt:
		if disable_after_hit:
			set_deferred("monitoring", false)
			queue_free()
		body._death()
