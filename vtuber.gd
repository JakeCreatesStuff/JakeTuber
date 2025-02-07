extends CharacterBody2D

class_name Vtuber

@export var input: Control
@export var BOUNCE_VELOCITY = -200
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var volume
var talking
var screaming
var pos
var spoke = false
var expression = 1

func _ready():
	pos = position.y
	
func _physics_process(delta):
	velocity.y += gravity * delta
	volume = input.mic_input
	talking = input.talking
	screaming = input.screaming
	#print(pos)
	pos = position.y
	
	if talking:
		if !screaming:
			animated_sprite.play("Open")
		else:
			animated_sprite.play("Scream")
		if is_on_floor() and spoke == false:
			velocity.y = BOUNCE_VELOCITY
			spoke = true
	else:
		animated_sprite.play("Closed")
		spoke = false
		
	if Input.is_action_just_pressed("state 1"):
		print("recieved") 
	move_and_slide()
	
	
func expression_state()
	
