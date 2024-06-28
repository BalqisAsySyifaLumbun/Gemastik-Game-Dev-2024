extends Area2D

@export var ucing: CharacterBody2D

@onready var box = $AnimatedSprite2D

signal start_task

var animation_played = false

func _on_body_entered(body):
	if body.name == "MC" and !animation_played:
		ucing.disable_movement()
		box.play("dropped")
		Dialogic.start("box_jatuh")
		animation_played = true


func _on_animation_finished():
	print("ANIMASTNIAO")
	if Dialogic.current_timeline:
		await Dialogic.timeline_ended
	print("HSHSHSH")
	start_task.emit()
