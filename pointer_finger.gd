extends Area2D

var chibi:bool = false
var _pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ElgatoStreamDeck.on_key_down.connect(_chibi)
	position = Vector2(0, 1080)
	self.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chibi:
		if !_pressed:
			position = position.lerp(get_global_mouse_position(), 10*delta)
		else: 
			position = get_global_mouse_position()
	else:
		position = position.lerp(Vector2(0, 1080), 6*delta)

func _chibi(message: String):
	if message == "_chibi":
		if chibi:
			#position = Vector2(0, 1080)
			#self.visible = false
			chibi = false
		else:
			#self.visible = true
			chibi = true


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressed = event.pressed
