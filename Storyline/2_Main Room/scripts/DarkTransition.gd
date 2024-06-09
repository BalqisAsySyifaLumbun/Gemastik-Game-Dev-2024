extends Sprite2D

var fade_duration = 3.0 # Duration of the fade in seconds
var delay_duration = 3.0 # Delay duration after fade-in in seconds
var current_time = 0.0 # Current time elapsed
var delay_time = 0.0 # Current delay time elapsed
var is_fading = false # Flag to track if fading is in progress

func _ready():
	# Start the fade-in effect
	is_fading = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_fading:
		if current_time < fade_duration:
			current_time += delta
			var fade_amount = current_time / fade_duration # Calculate the amount of fade
			modulate.a = fade_amount # Adjust alpha value for fading
		else:
			# Fade-in complete, start delay
			is_fading = false
			delay_time += delta
			if delay_time >= delay_duration:
				pass
	else:
		pass
