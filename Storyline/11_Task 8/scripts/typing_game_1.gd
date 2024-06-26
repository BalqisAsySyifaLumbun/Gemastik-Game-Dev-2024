extends AnimatedSprite2D

var flag = 0
@onready var correct = %Correct
@onready var wrong = %Wrong

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tapme = [KEY_D,KEY_A,KEY_D,KEY_U]
	var animate = ['1','2','3','4']
	while flag < 4:
		if Input.is_key_pressed(tapme[flag]):
			flag += 1
			self.animation = animate[flag]
			correct.play()
		else:
			wrong.play()
	
