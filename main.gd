extends Node2D

var config = ConfigFile.new()

func _ready():
	var err = config.load("res://savegame.cfg")
	if err == OK:
		$BodyScene.position.x = config.get_value("BodyScene", "xPos")
		$BodyScene.position.y = config.get_value("BodyScene", "yPos")
		$BodyScene.scale.x = config.get_value("BodyScene", "xScale")
		$BodyScene.scale.y = config.get_value("BodyScene", "yScale")
		$Control.mic_slider = config.get_value("Control", "mic_slider")
		$Control.time_slider = config.get_value("Control", "time_slider")
		$Control.scream_slider = config.get_value("Control", "scream_slider")
		
func save():
	config.set_value("BodyScene", "xPos", $BodyScene.position.x)
	config.set_value("BodyScene", "yPos", $BodyScene.position.y)
	config.set_value("BodyScene", "xScale", $BodyScene.scale.x)
	config.set_value("BodyScene", "yScale", $BodyScene.scale.y)
	config.set_value("Control", "mic_slider", $Control.mic_slider)
	config.set_value("Control", "time_slider", $Control.time_slider)
	config.set_value("Control", "scream_slider", $Control.scream_slider)
	config.save("res://savegame.cfg")
	
func recover():
	pass

func _on_button_pressed():
	save()
