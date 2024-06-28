extends Node2D

var dialogue_is_running = false
@onready var ucing = $MC
var task1_scene = load("res://Storyline/4_Task 1/box_drag_drop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if !dialogue_is_running:
		dialogue_is_running = true
		ucing.disable_movement()
		Dialogic.start("gudang")
		await Dialogic.timeline_ended
		ucing.enable_movement()


func _on_box_start_task():
	TransitionScreen.transition_between()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(task1_scene)
