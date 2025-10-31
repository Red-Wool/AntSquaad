extends Area2D
@export var disable_after_hit: bool = true

func _ready() -> void: 
	monitoring = true
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node) -> void: 
	if body and body.has_method("die"):
		if disable_after_hit:
			set_deferred("monitoring", false)
		body.die()
