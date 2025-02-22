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
var blinking = false

var chibi:bool = false
var has_mouse:bool = false

var expression_check
var state_1 = "Base Closed"
var state_2 = "Base Closed Blink"
var state_3 = "Base Open"
var state_4 = "Base Open Blink"
var state_5 = "Base Closed"
var state_6 = "Base Closed Blink"
var state_7 = "Base Open"
var state_8 = "Base Open Blink"

func _ready():
	$blink_timer.start(randf_range(1,5))
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
	ElgatoStreamDeck.on_key_down.connect(_chibi)
	
func _physics_process(delta):
	velocity.y += gravity * delta
	volume = input.mic_input
	talking = input.talking
	screaming = input.screaming
	
	if Input.is_action_just_pressed("state 1"):
		expression = 1
		expression_state(expression)
	elif  Input.is_action_just_pressed("state 2"):
		expression = 2
		expression_state(expression)
	elif  Input.is_action_just_pressed("state 3"):
		expression = "2 scream"
		expression_state(expression)
		
		
	print(second_state)
		
	if talking:
		open = true
		if screaming or second_state:
			$scream_timer.start()
			second_state = true
			expression_state(str(expression) + " scream")
		else:
			expression_state(expression)
		if is_on_floor() and spoke == false:
			velocity.y = BOUNCE_VELOCITY
			spoke = true
			
		if blinking:
			animated_sprite.play(state_4)
		else:
			animated_sprite.play(state_3)
			
	else:
		open = false
		spoke = false
		if blinking:
			animated_sprite.play(state_2)
		else:
			animated_sprite.play(state_1)
		
	move_and_slide()
	
func _chibi(message: String):
	if chibi:
		Input.mouse_mode=Input.MOUSE_MODE_HIDDEN
		self.visible = false
		chibi = false
	else:
		Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
		self.visible = true
		chibi = true

func expression_state(check):

	match check:
		1:
			state_1 = "Base Closed"
			state_2 = "Base Closed Blink"
			state_3 = "Base Open"
			state_4 = "Base Open Blink"
			#print("state 1")
		2:
			state_1 = "Fear Closed"
			state_2 = "Fear Closed Blink"
			state_3 = "Fear Open"
			state_4 = "Fear Open Blink"
			#print("state 2")
		"2 scream":
			state_1 = "Panic Closed"
			state_2 = "Panic Closed Blink"
			state_3 = "Panic Open"
			state_4 = "Panic Open Blink"
			#print("state 2")

func _on_scream_timer_timeout():
	expression_state(expression)
	second_state = false
	#print("timer up")

func _on_blink_timer_timeout():
	blinking = true
	print("blink")
	await get_tree().create_timer(0.15).timeout
	$blink_timer.start(randf_range(1,5))
	blinking = false


	#if talking:
		#open = true
		#
		#if is_on_floor() and spoke == false:
			#velocity.y = BOUNCE_VELOCITY
			#spoke = true
			#
		#if screaming or second_state:
				#if blinking:
					#pass
				#else:
					#pass
				#animated_sprite.play(state_4)
				#$scream_timer.start()
				#second_state = true
		#else:
			#animated_sprite.play(state_3)
			#
	#else:
		#open = false
		#spoke = false
		#
		#if second_state:
			#animated_sprite.play(state_2)
		#else:
			#animated_sprite.play(state_1)
