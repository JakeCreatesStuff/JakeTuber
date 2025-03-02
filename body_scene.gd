extends Node2D

var has_mouse:bool = false
var chibi:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print(position.x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ScaleUp"):
		scale.x = scale.x+0.02
		scale.y = scale.y+0.02
	elif Input.is_action_just_pressed("ScaleDown"):
		scale.x = scale.x-0.02
		scale.y = scale.y-0.02
	elif Input.is_action_just_pressed("Reset"):
		scale.x = 1
		scale.y = 1
		
	chibi = $Vtuber.chibi
	
	if Input.is_action_pressed("left_click") and has_mouse and !chibi:
		position = position.lerp(get_global_mouse_position(), 60*delta)

func _on_area_2d_mouse_entered():
	has_mouse = true
	print("entered")

func _on_area_2d_mouse_exited():
	has_mouse = false
	print("exited")
