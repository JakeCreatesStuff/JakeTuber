extends Area2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
var chibi:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ElgatoStreamDeck.on_key_down.connect(_chibi)
	position = Vector2(1664, 256)
	self.visible = true
	animated_sprite.play("bubble")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chibi:
		position = position.lerp(Vector2(1664, 256), 6*delta)
	else:
		position = position.lerp(Vector2(2136, -104), 6*delta)

func _chibi(message: String):
	if message == "_chibi":
		if chibi:
			#self.visible = false
			chibi = false
		else:
			#self.visible = true
			chibi = true
