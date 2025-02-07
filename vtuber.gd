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
var open = false
var second_state = false

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
		#if !screaming:
			#animated_sprite.play("Open")
		#else:
			#animated_sprite.play("Scream")
		if is_on_floor() and spoke == false:
			velocity.y = BOUNCE_VELOCITY
			spoke = true
	else:
		#animated_sprite.play("Closed")
		spoke = false
		
	if Input.is_action_just_pressed("state 1"):
		expression = 1
	if Input.is_action_just_pressed("state 2"):
		expression = 2
	move_and_slide()
	expression_state()
	
	
func expression_state():
	#print(second_state)
	if talking:
		open = true
	else:
		open = false
	match expression:
		1:
			if talking:
				if screaming or second_state:
					animated_sprite.play("Angry Open")
					$scream_timer.start()
					second_state = true
				else:
					animated_sprite.play("Base Open")
			else:
				if second_state:
					animated_sprite.play("Angry Closed")
				else:
					animated_sprite.play("Base Closed")
		2:
			pass


func _on_scream_timer_timeout():
	second_state = false
	print("timer up")
