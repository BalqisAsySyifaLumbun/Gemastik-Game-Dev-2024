extends CollisionShape2D


func _on_body_entered(body):
	Dialogic.start("ke_bawah")
		
		#if Input.is_key_pressed(KEY_X):
			#get_tree().change_scene_to_file("res://Storyline/2_Main Room/main_room_upper.tscn")

func _on_body_exited(body):
	pass
