extends Area2D

var chibi:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ElgatoStreamDeck.on_key_down.connect(_chibi)
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position.lerp(get_global_mouse_position(), 10*delta)

func _chibi(message: String):
	if chibi:
		self.visible = true
		chibi = false
	else:
		self.visible = false
		chibi = true
