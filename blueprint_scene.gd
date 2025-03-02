extends Node2D

@onready var _lines: Node2D = $Line2D

var _pressed: bool = false
var _current_line: Line2D = null
var chibi:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ElgatoStreamDeck.on_key_down.connect(_recieve)
	position = Vector2(-1930, 0)
	self.visible = true

func _process(delta):
	if Input.is_action_just_pressed("state 1"):
		_current_line = null
		for i in _lines.get_children():
			i.queue_free()
		#print("DELETED")
	if Input.is_action_just_pressed("state 2"):
		var last_line = _lines.get_child(-1)
		if last_line:
			last_line.queue_free()
			
	if chibi:
		position = position.lerp(Vector2(0, 0), 6*delta)
	else:
		position = position.lerp(Vector2(-1930, 0), 6*delta)
	#print(_lines.get_children())
	

func _recieve(message: String):
	if message == "_chibi":
		if chibi:
			#self.visible = true
			chibi = false
		else:
			#self.visible = false
			chibi = true

func _input(event: InputEvent) -> void:
	if chibi:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				_pressed = event.pressed
				if _pressed:
					_current_line = Line2D.new()
					_current_line.default_color = Color.ANTIQUE_WHITE
					_current_line.width = 4
					_lines.add_child(_current_line)
					_current_line.add_point(event.position)
		elif event is InputEventMouseMotion and _pressed:
			if _current_line:
				_current_line.add_point(event.position)
