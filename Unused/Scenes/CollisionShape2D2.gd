extends CollisionShape2D
@onready var player = get_parent().get_parent().get_parent().get_node('MC/Sprite2D')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.x < position.x:
		# Flip the character horizontally
		pass
	else:
		# Reset the character's scale if the player is not to the left
		get_tree().change_scene("main_2.tscn")
