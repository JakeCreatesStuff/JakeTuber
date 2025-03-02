extends CanvasLayer

var chibi:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ElgatoStreamDeck.on_key_down.connect(_chibi)
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _chibi(message: String):
	pass
	#if chibi:
		#self.visible = true
		#chibi = false
	#else:
		#self.visible = false
		#chibi = true
