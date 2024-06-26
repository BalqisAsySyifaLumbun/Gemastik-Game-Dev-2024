extends Area2D


func _on_body_entered(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_in")


func _on_body_exited(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_out")
