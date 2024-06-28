extends Node2D

var dialogue_is_running = false
@onready var ucing = $MC

# Called when the node enters the scene tree for the first time.
func _ready():
	if !dialogue_is_running:
		dialogue_is_running = true
		ucing.disable_movement()
		Dialogic.start("box_selesai")
		await Dialogic.timeline_ended
		ucing.enable_movement()

