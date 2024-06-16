extends Node2D

var dropped_items_count = 0
var highest_z_index = 0

func increment_count():
	dropped_items_count += 1
	print("Total items in box: " + str(dropped_items_count))

func get_new_highest_z_index():
	highest_z_index += 1
	return highest_z_index
