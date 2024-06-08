extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sprite = null
var fade_duration = 2.0
var current_time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sprite == null:
		sprite = get_parent().get_node('MC/CollisionShape2D')
		if sprite == null:
			print("Sprite not found!")
			return

	var player_global_pos = sprite.global_position
	var mc_global_pos = global_position
	var distance = player_global_pos.distance_to(mc_global_pos)

	if distance <= 600:
		current_time += delta
	else:
		current_time -= delta

	current_time = clamp(current_time, 0.0, fade_duration)
	modulate.a = current_time / fade_duration

	# Adjust sprite visibility based on distance
	if distance <= 600:
		sprite.visible = true
	else:
		sprite.visible = false

	#print("Player Position:", player_global_pos)
	#print("Sprite Position:", mc_global_pos)
	#print("Distance:", distance)
	#print("Alpha:", modulate.a)
