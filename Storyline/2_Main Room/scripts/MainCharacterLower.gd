extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D
@onready var label_pintu = get_parent().get_node('Go_Door7')
@onready var text_edit_5 = get_parent().get_node('TextEdit5')
@onready var naik = get_parent().get_node('IconNaik')
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var player_global_pos = sprite_2d.global_position
	var pintu_global_pos = label_pintu.global_position
	var naik_global_pos = naik.global_position
	var distance_pintu = player_global_pos.distance_to(pintu_global_pos)
	#print("DistancePintu:", distance_pintu)
	#var sprite_global_pos = sprite.global_position
	
	if player_global_pos.distance_to(naik_global_pos) <= 650:
		if Input.is_action_just_pressed("talk"):
			Dialogic.start("ke_koridor_utama")
			Dialogic.signal_event.connect(DialogicSignal)
			
	if distance_pintu < 600:
		#text_edit_5.visible = true
		if Input.is_action_just_pressed("talk"):
			Dialogic.start("gudang")
			Dialogic.signal_event.connect(DialogicSignal2)
			
	else:
		text_edit_5.visible = false
	
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

func DialogicSignal(argument:String):
	if argument == "Ya":
		get_tree().change_scene_to_file("res://Storyline/2_Main Room/main_room.tscn")

func DialogicSignal2(argument:String):
	if argument == "Ya":
		get_tree().change_scene_to_file("res://Storyline/3_Storage Room/storage_room.tscn")
