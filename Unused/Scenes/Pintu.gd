extends Area2D

@onready var player = get_parent().get_node('MC/CollisionShape2D')
var interaction_distance = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	# Perform any initialization here
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_within_interaction_distance():
		print("Within interaction distance")
		if Input.is_action_pressed("talk"):
			print("Talk action pressed")
			handle_interaction()

func is_within_interaction_distance():
	return global_position.distance_to(player.global_position) <= interaction_distance

func handle_interaction():
	if get_tree().get_current_scene().get_filename() != "res://Scenes/main_2.tscn":
		print("Interacting with player within 100 pixels")
		var new_scene = "res://Scenes/main_2.tscn"
		get_tree().change_scene(new_scene)
		# Add additional logic here based on your game requirements
	else:
		print("Already in the main_2 scene")
