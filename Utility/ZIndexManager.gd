extends Node

var highest_z_index = 0

func get_new_highest_z_index():
	highest_z_index += 1
	return highest_z_index

func reset_z_index():
	highest_z_index = 0
