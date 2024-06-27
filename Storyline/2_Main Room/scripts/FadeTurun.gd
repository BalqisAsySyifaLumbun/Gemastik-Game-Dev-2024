extends Area2D


func _on_body_entered(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_in")
		if Input.is_key_pressed(KEY_X):
			get_tree().change_scene_to_file("res://Storyline/2_Main Room/main_room_lower.tscn")

func _on_body_exited(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_out")
