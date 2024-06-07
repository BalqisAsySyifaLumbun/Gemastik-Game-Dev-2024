extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#@onready var sprite = get_parent().get_node('Badak/CollisionShape2D')
@onready var text_leave = get_parent().get_node('TextEdit3')
@onready var text_edit = get_parent().get_node('TextEdit4')
var count = 0
var dialog_in_progress = false

func _physics_process(delta):
	
	var player_global_pos = sprite_2d.global_position
	#var sprite_global_pos = sprite.global_position
	
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

#	if (player_global_pos.x <= sprite_global_pos.x + 200) && (player_global_pos.x >= sprite_global_pos.x - 200):
#		if Input.is_action_just_pressed("talk") and not dialog_in_progress:
#			text_leave.visible = false
#			text_edit.visible = true
#			text_edit.text = "\n\n--Tekan tombol Enter untuk melanjutkan dialog--"
#			dialog_in_progress = true

#	if dialog_in_progress and Input.is_action_just_pressed("dialog"):
#		var array = ["Badak\nHalo, kamu murid baru, ya?", "Badak\nOh, namaku Cula. Sepertinya aku harus membantumu pergi ke ruang guru.", "Cula\nRuang guru arahnya lurus saja, dan pintu kuning yang kau temui adalah ruangannya.", "Cula\nSemoga beruntung."]
#		if count < array.size():
#			text_edit.text = array[count]
#			count += 1
#		else:
#			text_edit.visible = false
#			text_leave.visible = true
#			text_leave.text = "Cula\n    Aku lapar..."
#			dialog_in_progress = false
#			count = 0
