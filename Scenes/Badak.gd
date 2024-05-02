extends StaticBody2D

@onready var player = get_parent().get_node('Badak')
@onready var sprite = $Sprite

func _physics_process(_delta):
	look_at(player.position)
	
	# Check if the player is to the left of the character
	if player.position.x < position.x:
		# Flip the character horizontally
		sprite.scale.x = -1
	else:
		# Reset the character's scale if the player is not to the left
		sprite.scale.x = 1
