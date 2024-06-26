extends Node2D

var style: DialogicStyle = load("res://Dialogue/speaker_textbox.tres")

var dialogue_is_running := false
var door_dialogue := false

func _ready():
# PRELOAD TIMELINE TO REDUCE LAG
	style.prepare()
	Dialogic.preload_timeline("res://Dialogue/Timelines/empty_timeline.dtl")


func _on_area_papan_body_entered(body):
	if body.name == "MC" and !dialogue_is_running:
		dialogue_is_running = true
		print("MC MASUK NIH")
		Dialogic.start("intro_main_room")
		await Dialogic.timeline_ended
		dialogue_is_running = false


func _on_area_papan_body_exited(body):
	if body.name == "MC":
		print("MC KELUAR")
		Dialogic.end_timeline()
		dialogue_is_running = false


func _on_area_2d_body_entered(body):
	if body.name == "MC" and !dialogue_is_running:
		if door_dialogue:
			Dialogic.start("wrong_door")
			await Dialogic.timeline_ended
			dialogue_is_running = false


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
