extends Sprite2D

var fade_duration = 10.0 # Duration of the fade-out effect in seconds
var current_time = 0.0 # Current time elapsed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_time < fade_duration:
		current_time += delta
		var fade_amount = 1.0 - (current_time / fade_duration) # Calculate the amount of fade
		modulate.a = fade_amount # Adjust alpha value for fading
	else:
		modulate.a = 0.0 # Ensure the node is fully transparent once the fade-out is complete
