extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	value = $decay_timer.time_left


func _on_decay_timer_timeout():
	print("decay up")


func _on_control_talk_volume_reached():
	$decay_timer.start()
