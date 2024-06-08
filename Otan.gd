extends CharacterBody2D

@onready var player = get_parent().get_node('MC/CollisionShape2D')
var sprite = null

func _ready():
	# Assign the sprite node when the scene is ready
	sprite = $Sprite
	if sprite == null:
		print("Sprite node not found!")

func _physics_process(_delta):
	if player:
		# Calculate the direction to the player
		var direction_to_player = player.global_position - global_position

		# Flip the character sprite horizontally based on the direction
		if direction_to_player.x < 0:
			# If player is to the left, flip character sprite
			if sprite:
				sprite.scale.x = -1
		else:
			# If player is to the right, reset character sprite
			if sprite:
				sprite.scale.x = 1
	else:
		print("Player node not found!")
