extends Area2D

@onready var pop_sound = $PopSound

@export var upper_room: PackedScene
@export var lower_room: PackedScene

var change_scene_upper = false
var change_scene_lower = false

func _on_body_entered(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_in")
		pop_sound.play()
		if name == "IconNaik":
			change_scene_upper = true
		elif name == "IconTurun":
			change_scene_lower = true


func _on_body_exited(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_out")
		if name == "IconNaik":
			change_scene_upper = false
		elif name == "IconTurun":
			change_scene_lower = false


func _input(event):
	if event.is_action_pressed("talk"):
		if change_scene_upper and upper_room:
			TransitionScreen.transition_between()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_packed(upper_room)
		elif change_scene_lower and lower_room:
			TransitionScreen.transition_between()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_packed(lower_room)

