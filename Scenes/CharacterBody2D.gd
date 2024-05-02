extends CharacterBody2D

@onready var player = get_parent().get_node('MC/CollisionShape2D')
@onready var sprite = get_parent().get_node('Badak/AnimatedSprite2D')


	
func _physics_process(delta):
	
	var player_global_pos = player.global_position
	var sprite_global_pos = sprite.global_position
	
	if player_global_pos.x < sprite_global_pos.x:
		sprite.scale.x = -2
	else:
		sprite.scale.x = 2
	

		
