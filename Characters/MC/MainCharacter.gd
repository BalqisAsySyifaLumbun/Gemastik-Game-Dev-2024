extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var otan = get_parent().get_node('Otan/CollisionShape2D')
@onready var text_edit = get_parent().get_node('TextEdit4')
@onready var ikon_naik = $"../GuideIcon/IconNaik"
@onready var ikon_turun = $"../GuideIcon/IconTurun"

var count = 0
var dialog_in_progress = false
var gelap_fade_duration = 3.0
var gelap_current_time = 0.0

func _physics_process(delta):
	
	var player_global_pos = sprite_2d.global_position
	var sprite_global_pos = otan.global_position
	var naik_global_pos = ikon_naik.global_position
	var turun_global_pos = ikon_turun.global_position
	
	
	
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
	if (player_global_pos.x <= sprite_global_pos.x + 400) && (player_global_pos.x >= sprite_global_pos.x - 400):
		text_edit.visible = true
		#region DIALOG WITH OTAN
		if dialog_in_progress and Input.is_action_just_pressed("talk"):
			Dialogic.start("main_room")
			dialog_in_progress = false
#endregion
		if not dialog_in_progress:
			dialog_in_progress = true
	else:
		text_edit.visible = false
#endregion =====================================================================
	
	if (player_global_pos.x - naik_global_pos.x <= 100) && (player_global_pos.x - naik_global_pos.x >= -100):
		if Input.is_action_just_pressed("talk"):
			Dialogic.start("ke_atas")
			Dialogic.signal_event.connect(DialogicSignal)
	
	if (player_global_pos.x - turun_global_pos.x <= 100) && (player_global_pos.x - turun_global_pos.x >= -100):
		if Input.is_action_just_pressed("talk"):
			Dialogic.start("ke_bawah")
			Dialogic.signal_event.connect(DialogicSignal2)

func DialogicSignal(argument:String):
	if argument == "Ya":
		get_tree().change_scene_to_file("res://Storyline/2_Main Room/main_room_upper.tscn")

func DialogicSignal2(argument:String):
	if argument == "Ya":
		get_tree().change_scene_to_file("res://Storyline/2_Main Room/main_room_lower.tscn")
