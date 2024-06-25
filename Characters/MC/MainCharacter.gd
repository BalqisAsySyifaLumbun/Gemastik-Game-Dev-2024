extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var otan = get_parent().get_node('Otan/CollisionShape2D')
@onready var text_edit = get_parent().get_node('TextEdit4')


var count = 0
var dialog_in_progress = false
var gelap_fade_duration = 3.0
var gelap_current_time = 0.0

func _physics_process(delta):
	
	var player_global_pos = sprite_2d.global_position
	var sprite_global_pos = otan.global_position
	
	
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
		if not dialog_in_progress:
			dialog_in_progress = true
	else:
		text_edit.visible = false
#endregion =====================================================================

#region DIALOG WITH OTAN
	if dialog_in_progress and Input.is_action_just_pressed("talk"):
		Dialogic.start("main_room")
		dialog_in_progress = false
#endregion
