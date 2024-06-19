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
	kotak.animation = "idle"
	var distance = main_char.global_position.distance_to(text_gudang2.global_position )
	print(distance)
	if distance <= 600:
		text_gudang2.visible = true
	else:
		text_gudang2.visible=false
		#print("Nodes not properly initialized.")
