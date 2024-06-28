extends Node2D

var style: DialogicStyle = load("res://Dialogue/speaker_textbox.tres")

var dialogue_is_running := false
var on_trio := false

func _ready():
# PRELOAD TIMELINE TO REDUCE LAG
	style.prepare()
	Dialogic.preload_timeline("res://Dialogue/Timelines/empty_timeline.dtl")


#region DIALOGUE MANAGER
func _dialogue_start(body, dialogue: String):
	if body.name == "MC" and !dialogue_is_running:
		if dialogue == "dialog_trio_hutan":
			on_trio= true # Replace with function body.

func _dialogue_stop(body, dialogue: String):
	if body.name == "MC":
		if dialogue_is_running:
			dialogue_stopper()
		if dialogue == "dialog_trio_hutan":
			on_trio= true

func _input(event):
	if !dialogue_is_running:
		if event.is_action_pressed("talk") and on_trio:
			dialogue_starter("dialog_trio_hutan")
			on_trio= true
#endregion ===========================


#region DIALOGUE DRIVER
func dialogue_starter(dialogue: String):
	dialogue_is_running = true
	Dialogic.start(dialogue)
	await Dialogic.timeline_ended
	dialogue_is_running = false

func dialogue_stopper():
	Dialogic.end_timeline()
	dialogue_is_running = false
#endregion ===========================
#




func _on_body_entered(body):
	pass # Replace with function body.
