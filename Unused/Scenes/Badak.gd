extends CharacterBody2D

@onready var player = get_parent().get_node('MC/CollisionShape2D')
@onready var sprite = $Sprite

func _physics_process(_delta):
	if player:
		look_at(player.position)
		
		# Check if the player is to the left of the character
		if player.position.x < position.x:
			# Flip the character horizontally
			sprite.scale.x = -3
		else:
			# Reset the character's scale if the player is not to the left
			sprite.scale.x = 3
	else:
		print("Player node not found!")
