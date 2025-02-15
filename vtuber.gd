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
var state_1 = "Base Closed"
var state_2 = "Base Closed Blink"
var state_3 = "Base Open"
var state_4 = "Base Open Blink"

func _ready():
	pos = position.y
	ElgatoStreamDeck.on_key_down.connect(_test)
	
func _process(delta):
	velocity.y += gravity * delta
	volume = input.mic_input
	talking = input.talking
	screaming = input.screaming
	
	if Input.is_action_just_pressed("state 1"):
		expression = 1
		expression_state()
	elif  Input.is_action_just_pressed("state 2"):
		expression = 2
		expression_state()
		
	if Input.is_action_just_pressed("ScaleUp"):
		scale.x = scale.x+0.02
		scale.y = scale.y+0.02
	elif Input.is_action_just_pressed("ScaleDown"):
		scale.x = scale.x-0.02
		scale.y = scale.y-0.02
	elif Input.is_action_just_pressed("Reset"):
		scale.x = 1
		scale.y = 1
	if talking:
		open = true
		
		if is_on_floor() and spoke == false:
			velocity.y = BOUNCE_VELOCITY
			spoke = true
			
		if screaming or second_state:
			animated_sprite.play(state_4)
			$scream_timer.start()
			second_state = true
		else:
			animated_sprite.play(state_3)
			
	else:
		open = false
		spoke = false
		
		if second_state:
			animated_sprite.play(state_2)
		else:
			animated_sprite.play(state_1)
	move_and_slide()
	
func _test(message: String):
	print("recieved")

func expression_state():

	match expression:
		1:
			state_1 = "Base Closed"
			state_2 = "Base Closed Blink"
			state_3 = "Base Open"
			state_4 = "Base Open Blink"
			print("state 1")
		2:
			print("state 2")


func _on_scream_timer_timeout():
	second_state = false
	print("timer up")
