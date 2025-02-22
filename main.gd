extends Node2D

var config = ConfigFile.new()

func _ready():
	var err = config.load("res://savegame.cfg")
	if err == OK:
		$BodyScene.position.x = config.get_value("BodyScene", "xPos")
		$BodyScene.position.y = config.get_value("BodyScene", "yPos")

func save():
	config.set_value("BodyScene", "xPos", $BodyScene.position.x)
	config.set_value("BodyScene", "yPos", $BodyScene.position.y)
	config.save("res://savegame.cfg")
	
func recover():
	pass

func _on_button_pressed():
	save()
