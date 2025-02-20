extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
