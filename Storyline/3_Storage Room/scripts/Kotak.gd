extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DELAY_FRAMES = 2 * 60  # 2 seconds at 60 FPS
const TEXT_DELAY_FRAMES = 10 * 60  # 10 seconds at 60 FPS

@onready var kotak = get_parent().get_node('Kotak/AnimatedSprite2D')
@onready var kotak2 = get_parent().get_node('Kotak/CollisionShape2D')
@onready var main_char = get_parent().get_node('MC/CollisionShape2D')
@onready var text_gudang = get_parent().get_node('RichTextLabel')
@onready var text_gudang2 = get_parent().get_node('RichTextLabel2')


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_played = false
var text2_shown = false
var delay_counter = 0
var text_delay_counter = 0

func _ready():
	if kotak != null:
		print("Kotak node path:", kotak.get_path())
	else:
		print("Kotak node is null")

	if main_char != null:
		print("Main character node path:", main_char.get_path())
	else:
		print("Main character node is null")

func _physics_process(delta):
	# Check if nodes are properly initialized
	if main_char != null and kotak != null:
		var player_global_pos = main_char.global_position
		var text_gudang_global_pos = text_gudang.global_position
		var sprite2_global_pos = kotak2.global_position
		
		
		# Calculate the distance between the characters
		var distance_a = player_global_pos.x - text_gudang_global_pos.x
		print("DistanceA:", distance_a)
		var distance = player_global_pos.distance_to(sprite2_global_pos)
		print("Distance:", distance)
		
		if distance_a >= 250 || distance_a <= 0 :
			#print("False")
			text_gudang.visible = false
		else:
			text_gudang.visible = true
			if Input.is_action_just_pressed("talk"):
				text_gudang.text = "Ini sia sia, pintunya terkunci,\naku harus mencari cara keluar lain!"
			
		
		# Check if the distance is within a certain range
		if distance <= 250 && !animation_played:
			kotak.animation = "dropped"  # Set animation on AnimatedSprite node
			animation_played = true
			delay_counter = 0  # Reset delay counter
		elif animation_played:
			# Check if the delay frames have passed
			delay_counter += 1
			if delay_counter >= DELAY_FRAMES:
				kotak.animation = "mess"  # Set animation on AnimatedSprite node
				
				# Show text and reset text delay counter if not shown already
				if !text2_shown && text_delay_counter <= TEXT_DELAY_FRAMES:
					text_gudang2.visible = true
					text2_shown = true
					text_delay_counter = 0  # Reset text delay counter
				else:
					if distance >= 400:
						text_gudang2.visible = false
					else:
						text_gudang2.visible = true
						if Input.is_action_just_pressed("talk"):
							get_tree().change_scene_to_file("res://Storyline/4_Task 1/box_drag_drop.tscn")
						
				
				# Increment text delay counter
				text_delay_counter += 1
		else:
			# Reset animation state when the characters are not in range
			kotak.animation = "idle"  # Set idle animation
			animation_played = false
	else:
		pass
		#print("Nodes not properly initialized.")
