extends Area2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
var chibi:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ElgatoStreamDeck.on_key_down.connect(_chibi)
	self.visible = false
	animated_sprite.play("bubble")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _chibi(message: String):
	if chibi:
		self.visible = true
		chibi = false
	else:
		self.visible = false
		chibi = true
