class_name Powerable extends Node2D

@export var outputs : Array[Powerable]
@export var output_connection_displays : Array[PowerConnectionDisplay]

var inputs : Array[bool]
var output_indexes : Array[int]
var output = false

@onready var power_connector_prefab : PackedScene = preload("res://Prefabs/power_connection.tscn")

func _ready():
	for output in outputs:
		output_indexes.append(output._add_input())
		
		var power_connector : PowerConnectionDisplay = power_connector_prefab.instantiate()
		add_child(power_connector)
		power_connector.position = Vector2.ZERO
		power_connector._create_display_power(self, output)
		output_connection_displays.append(power_connector)
		
	call_deferred("_process_input")

func _add_input():
	inputs.append(false)
	return inputs.size() - 1
	
func _set_output(val):
	output = val;
	for i in outputs.size():
		var index = output_indexes[i]
		outputs[i]._set_input(index, val)
		output_connection_displays[i].material.set_shader_parameter("powered", val)

func _set_input(index, val):
	inputs[index] = val
	_process_input()
	
func _process_input():
	pass
