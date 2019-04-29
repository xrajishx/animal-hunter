extends Node

var current_level

var levels = [
	{
		"time_to_kill": 20.0,
		"animals_to_kill": 10
	},
	{
		"time_to_kill": 30.0,
		"animals_to_kill": 20
	},
	{
		"time_to_kill": 40.0,
		"animals_to_kill": 30
	},
	{
		"time_to_kill": 60.0,
		"animals_to_kill": 55
	}
]

func start_level(level):
	current_level = level
	goto_scene("res://Main.tscn")

func goto_scene(path):
	# warning-ignore:return_value_discarded
	get_tree().change_scene(path)