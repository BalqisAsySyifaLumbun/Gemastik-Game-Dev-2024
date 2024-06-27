extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

@onready var ucing = $Sprite2D
@onready var walking_sound = $Walk

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
#region ANIMATION AND MOVEMENT MECHANICS
	if (velocity.x > 1 || velocity.x < -1):
		ucing.animation = "walk"
	else:
		ucing.animation = "idle"

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if walking_sound.playing:
			walking_sound.stop()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED-50)
	
	# Play or stop walking sound based on movement and ground state
	if direction != 0 and is_on_floor():
		if not walking_sound.playing:
			walking_sound.play()
	else:
		if walking_sound.playing:
			walking_sound.stop()

	move_and_slide()
	
	var isLeft = velocity.x < 0
	ucing.flip_h = isLeft
#endregion =============================================
	