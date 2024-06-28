extends Area2D


func _on_area_entered(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_in")
		if Input.is_key_pressed(KEY_X):
			Dialogic.start("wrong_door")

func _on_area_exited(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_out")
