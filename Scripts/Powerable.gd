class_name Powerable extends Node2D

@export var outputs : Array[Powerable]

var inputs : Array[bool]
var output_indexes : Array[int]
var output = false

func _ready():
	for output in outputs:
		output_indexes.append(output._add_input())
	call_deferred("_process_input")

func _add_input():
	inputs.append(false)
	return inputs.size() - 1
	
func _set_output(val):
	output = val;
	for i in outputs.size():
		var index = output_indexes[i]
		outputs[i]._set_input(index, val)

func _set_input(index, val):
	inputs[index] = val
	_process_input()
	
func _process_input():
	pass
