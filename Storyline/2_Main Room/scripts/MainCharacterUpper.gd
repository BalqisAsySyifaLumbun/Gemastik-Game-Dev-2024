extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D
@onready var label_pintu2 = get_parent().get_node('Go_Door2')
@onready var label_pintu3 = get_parent().get_node('Go_Door3')
@onready var label_pintu7 = get_parent().get_node('Go_Door7')
@onready var text_edit_door_2 = get_parent().get_node('TextEditDoor2')
@onready var text_edit_door_3 = get_parent().get_node('TextEditDoor3')
@onready var text_edit_door_7 = get_parent().get_node('TextEditDoor7')
@onready var turun = get_parent().get_node('IconTurun')
@onready var walking_sound = $Walk
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var player_global_pos = sprite_2d.global_position
	var turun_global_pos = turun.global_position
	var wrong_open = false
	
	if player_global_pos.distance_to(turun_global_pos) <= 650:
		if Input.is_action_just_pressed("talk"):
			Dialogic.start("ke_koridor_utama")
			Dialogic.signal_event.connect(DialogicSignal)
	
	if player_global_pos.distance_to(label_pintu2.global_position) < 600:
		if Input.is_action_just_pressed("talk"):
			Dialogic.start("wrong_door")
			
	if player_global_pos.distance_to(label_pintu3.global_position) < 600:
		if Input.is_action_just_pressed("talk"):
			Dialogic.start("wrong_door")
	
	if player_global_pos.distance_to(label_pintu7.global_position) < 600:
		if Input.is_action_just_pressed("talk"):
			Dialogic.start("wrong_door")
	
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "walk"
	else:
		sprite_2d.animation = "idle"
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	var isleft = velocity.x < 0
	sprite_2d.flip_h = isleft
	
	if direction != 0 and is_on_floor():
		if not walking_sound.playing:
			walking_sound.play()
	else:
		if walking_sound.playing:
			walking_sound.stop()

func DialogicSignal(argument:String):
	if argument == "Ya":
		get_tree().change_scene_to_file("res://Storyline/2_Main Room/main_room.tscn")
