extends Control

signal talk_volume_reached

var mic_input
var mic_slider
var scream_slider
var time_slider
var decay_value
var talking = false
var screaming = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mic_slider = 0
	time_slider = 0
	decay_value = 0
	scream_slider = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(talking)
	if mic_input != null:
		if mic_input >= mic_slider:
			emit_signal("talk_volume_reached")
			if mic_input >= scream_slider:
				screaming = true
		if decay_value > time_slider:
			talking = true
		else:
			talking = false
			screaming = false

func _on_volume_input_value_changed(value):
	mic_input = value
	#print(mic_input)

func _on_volume_selection_value_changed(value):
	mic_slider = value
	#print(mic_slider)

func _on_time_selection_value_changed(value):
	time_slider = value
	#print(time_slider)

func _on_decay_bar_value_changed(value):
	decay_value = value

func _on_scream_selection_value_changed(value):
	scream_slider = value
