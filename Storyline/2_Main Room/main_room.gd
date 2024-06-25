extends Node2D

var style: DialogicStyle = load("res://Dialogue/speaker_textbox.tres")

var dialogue_is_running := false
var door_dialogue := false


# Called when the node enters the scene tree for the first time.
func _ready():
	style.prepare()
	Dialogic.preload_timeline("res://Dialogue/Timelines/empty_timeline.dtl")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_papan_body_entered(body):
	if body.name == "MC":
		print("MC MASUK NIH")
		Dialogic.start("intro_main_room")


func _on_area_papan_body_exited(body):
	if body.name == "MC":
		print("MC KELUAR")


func _on_area_2d_body_entered(body):
	if body.name == "MC":
		if not dialogue_is_running:
			if door_dialogue:
				Dialogic.start("wrong_door")


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
