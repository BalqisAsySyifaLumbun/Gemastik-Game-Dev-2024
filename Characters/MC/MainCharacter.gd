extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#@onready var sprite = get_parent().get_node('Badak/CollisionShape2D')
@onready var otan = get_parent().get_node('Otan/CollisionShape2D')
@onready var text_edit = get_parent().get_node('TextEdit4')
@onready var instruction = get_parent().get_node('TextEdit3')
#@onready var text_edit_5 = get_parent().get_node('TextEdit5')
#@onready var label_pintu = get_parent().get_node('Go_Door')
@onready var label_pintu4 = get_parent().get_node('Go_Door4')
@onready var label_pintu5 = get_parent().get_node('Go_Door5')
@onready var label_pintu6 = get_parent().get_node('Go_Door6')

@onready var text_edit_door_2 = get_parent().get_node('TextEditDoor2')
@onready var text_edit_door_3 = get_parent().get_node('TextEditDoor3')
@onready var text_edit_door_4 = get_parent().get_node('TextEditDoor4')
@onready var text_edit_door_5 = get_parent().get_node('TextEditDoor5')
@onready var text_edit_door_6 = get_parent().get_node('TextEditDoor6')

@onready var gelap = get_parent().get_node('DarkLeave')

@onready var turun = get_parent().get_node('IconTurun')
@onready var naik = get_parent().get_node('IconNaik')

var count = 0
var dialog_in_progress = false
var gelap_fade_duration = 3.0
var gelap_current_time = 0.0

func _physics_process(delta):
	
	var player_global_pos = sprite_2d.global_position
	var turun_global_pos = turun.global_position
	var naik_global_pos = naik.global_position
	var sprite_global_pos = otan.global_position
	
#region CHANGE SCENE TO UPPER / LOWER ROOM
	if player_global_pos.distance_to(turun_global_pos) <= 650:
		if Input.is_action_just_pressed("talk"):
			TransitionScreen.transition_between()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_file("res://Storyline/2_Main Room/main_room_lower.tscn")
	if player_global_pos.distance_to(naik_global_pos) <= 650:
		if Input.is_action_just_pressed("talk"):
			TransitionScreen.transition_between()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_file("res://Storyline/2_Main Room/main_room_upper.tscn")
#endregion =================================

#region GOING TO PINTU
	var wrong_open = false
		
	if player_global_pos.distance_to(label_pintu4.global_position) < 600:
		if Input.is_action_just_pressed("talk") && wrong_open == false:
			wrong_open = true
			text_edit_door_4.visible = true
	else:
		wrong_open = false
		text_edit_door_4.visible = false
	
	if player_global_pos.distance_to(label_pintu5.global_position) < 600:
		if Input.is_action_just_pressed("talk") && wrong_open == false:
			wrong_open = true
			text_edit_door_5.visible = true
	else:
		wrong_open = false
		text_edit_door_5.visible = false
		
	if player_global_pos.distance_to(label_pintu6.global_position) < 600:
		if Input.is_action_just_pressed("talk") && wrong_open == false:
			wrong_open = true
			text_edit_door_6.visible = true
	else:
		wrong_open = false
		text_edit_door_6.visible = false
#endregion =============================================================
	
#region ANIMATION AND MOVEMENT MECHANICS
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
#endregion =============================================
	
#region INSTRUCTION TEXT
	if (player_global_pos.x <= instruction.global_position.x + 150) && (player_global_pos.x >= instruction.global_position.x - 150):
		#Dialogic.start("intro_main_room")
		instruction.visible = false
		if Input.is_action_just_pressed("talk"):
			
			instruction.text = "“Baiklah, sepertinya ini\ntidak akan terlalu buruk.”"
	else:
		instruction.text = "Clawns & Paws Haven\nmerupakan sekolah dan panti asuhan\nuntuk semua putra-putri kalangan satwa.\nKami memberikan cinta\ndan kasih kepada siapapun” "
		instruction.visible = false

	if (player_global_pos.x <= sprite_global_pos.x + 400) && (player_global_pos.x >= sprite_global_pos.x - 400):
		text_edit.visible = true
		if not dialog_in_progress:
			dialog_in_progress = true
	else:
		text_edit.visible = false
#endregion =====================================================================

#region DIALOG WITH OTAN
	if dialog_in_progress and Input.is_action_just_pressed("dialog"):
		Dialogic.start("main_room")
		dialog_in_progress = false
		#var array = ["Orangutan\n\nHai, apakah kau penghuni baru?", "Orangutan\n\nNamaku Otan!\nCobalah cari ruangan tak terkunci\ndengan pintu warna biru!", "Ucing\n\nApakah itu ruang guru?", "Otan\n\nCari saja~!\nKamu pasti akan menyukainya!!!"]
		#if count < array.size():
			#text_edit.text = array[count]
			#count += 1
		#else:
			#text_edit.text = "Otan\n\nHihihi.."
			#dialog_in_progress = false
			#count = 0
#endregion
