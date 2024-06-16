extends Control

var video_duration = 27.0 # Duration of the fade in seconds
var current_time = 0.0 # Current time elapsed
var modulate_color = Color(1, 1, 1, 0) # Initial color with alpha set to 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_time += delta # Increment current_time by delta
	print(current_time)
	# Check if current_time exceeds video_duration
	if current_time >= video_duration:
		modulate_color.a = 1 # Set alpha to 1 (fully visible)
	else:
		# Calculate alpha based on current time
		modulate_color.a = 0.05

	# Apply modulate_color to the node's modulate property
	modulate = modulate_color
