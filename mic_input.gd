extends AudioStreamPlayer

func _on_mic_refresh_timeout():
	playing = false
	await get_tree().create_timer(0.1).timeout
	playing = true
	print("mic reset")
