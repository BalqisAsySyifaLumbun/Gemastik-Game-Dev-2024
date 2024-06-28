extends Area2D

@export var ucing: CharacterBody2D

var upper_room = load("res://Storyline/2_Main Room/main_room_upper.tscn")
var lower_room = load("res://Storyline/2_Main Room/main_room_lower.tscn")
var main_room = load("res://Storyline/2_Main Room/main_room.tscn")

var change_scene_upper = false
var change_scene_lower = false
var change_scene_main = false

func _on_body_entered(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_in")
		$PopSound.play()
		if name == "IconNaik":
			print("printstatement")
			change_scene_upper = true
		elif name == "IconTurun":
			change_scene_lower = true
		elif name == "IconToMain":
			change_scene_main = true


func _on_body_exited(body):
	if body.name == "MC":
		$AnimationPlayer.play("fade_out")
		if name == "IconNaik":
			print("printstatementyyy")
			change_scene_upper = false
		elif name == "IconTurun":
			change_scene_lower = false
		elif name == "IconToMain":
			change_scene_main = false


func _input(event):
	if event.is_action_pressed("talk"):
		if change_scene_upper:
			GameStateManager.update_pos_main(ucing.global_position)
			TransitionScreen.transition_between()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_packed(upper_room)
		elif change_scene_lower:
			TransitionScreen.transition_between()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_packed(lower_room)
		elif change_scene_main:
			TransitionScreen.transition_between()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_packed(main_room)

