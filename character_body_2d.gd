extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#@onready var sprite = get_parent().get_node('Badak/CollisionShape2D')
@onready var otan = get_parent().get_node('Otan/CollisionShape2D')
@onready var text_edit = get_parent().get_node('TextEdit4')
@onready var text_edit_5 = get_parent().get_node('TextEdit5')
@onready var label_pintu = get_parent().get_node('Go_Door')
@onready var gelap = get_parent().get_node('DarkLeave')
var count = 0
var dialog_in_progress = false

func _physics_process(delta):
	
	var player_global_pos = sprite_2d.global_position
	var sprite_global_pos = otan.global_position
	var pintu_global_pos = label_pintu.global_position
	
	var distance_pintu = player_global_pos.distance_to(pintu_global_pos)
	#print("DistancePintu:", distance_pintu)
	#var sprite_global_pos = sprite.global_position
	if distance_pintu < 600:
		text_edit_5.visible = true
		if Input.is_action_just_pressed("talk"):
			gelap.visible = true
			get_tree().change_scene_to_file("res://main_2.tscn")
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

	if (player_global_pos.x <= sprite_global_pos.x + 200) && (player_global_pos.x >= sprite_global_pos.x - 200):
		if Input.is_action_just_pressed("talk") and not dialog_in_progress:
			text_edit.visible = true
			text_edit.text = "\n\n--Tekan tombol Enter untuk melanjutkan dialog--"
			dialog_in_progress = true

	if dialog_in_progress and Input.is_action_just_pressed("dialog"):
		var array = ["Orangutan\nHalo, kamu murid baru, ya?", "Orangutan\nNamaku Otan!. Sepertinya aku harus membantumu pergi ke ruang guru.", "Otan\nRuang guru arahnya lurus saja, dan pintu kuning yang kau temui adalah ruangannya.", "Otan\nSemoga beruntung, ya!"]
		if count < array.size():
			text_edit.text = array[count]
			count += 1
		else:
			text_edit.text = "Hihihi.."
			dialog_in_progress = false
			count = 0
