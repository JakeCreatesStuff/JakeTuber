extends Control

@onready var decay_value = get_node("VBoxContainer/decay_bar")
@onready var SpectrumArray = $AudioVisualizer.get_children()
signal talk_volume_reached

var record_bus_index: int
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance

var mic_input
var mic_slider
var scream_slider
var time_slider
var talking = false
var screaming = false
var menu = false
var magnitude : Array[float]

const VU_COUNT = 16
const HEIGHT = 120
const FREQ_MAX = 3500.0
const MIN_DB = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	mic_slider = 0
	time_slider = 0
	scream_slider = 0
	record_bus_index = AudioServer.get_bus_index("Record")
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var prev_hz = 0
	for i in range(1,VU_COUNT+1):   
		var hz = i * FREQ_MAX / VU_COUNT;
		var f = spectrum_analyzer.get_magnitude_for_frequency_range(prev_hz,hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length()))/MIN_DB,0,1)
		var height = energy * HEIGHT
		
		prev_hz = hz
		
		var spectrumVisualizer = SpectrumArray[i - 1]
		var tween = get_tree().create_tween()
		tween.tween_property(spectrumVisualizer, "size", Vector2(spectrumVisualizer.size.x, height), 0.05)
		
	var sample = AudioServer.get_bus_peak_volume_left_db(record_bus_index, 0)
	
	var mic_value = db_to_linear(sample)
	#var magnitude_u = spectrum_analyzer.get_magnitude_for_frequency_range(200, 400).length()
	#var magnitude_o = spectrum_analyzer.get_magnitude_for_frequency_range(400, 600).length()
	#var magnitude_a = spectrum_analyzer.get_magnitude_for_frequency_range(800, 1200).length()
	#var magnitude_e = spectrum_analyzer.get_magnitude_for_frequency_range(2200, 2600).length()
	#var magnitude_i = spectrum_analyzer.get_magnitude_for_frequency_range(3000, 3500).length()
	#var magnitude_u_db = linear_to_db(magnitude_u)
	#var magnitude_o_db = linear_to_db(magnitude_o)
	#var magnitude_a_db = linear_to_db(magnitude_a)
	#var magnitude_e_db = linear_to_db(magnitude_e)
	#var magnitude_i_db = linear_to_db(magnitude_i)
	
	#magnitude = [magnitude_u_db, magnitude_o_db, magnitude_a_db, magnitude_e_db, magnitude_i_db]
	#magnitude[1] = magnitude_o_db
	#magnitude[2] = magnitude_a_db
	#magnitude[3] = magnitude_e_db
	#magnitude[4] = magnitude_i_db
	#print(magnitude.max())
	#print('%s db' % round(magnitude_o_db))
	#if magnitude_o_db > magnitude_a_db:
		#print("o")
	#elif magnitude_e > magnitude_a:
		#print("e")
	#else:
		#print("a")

	if Input.is_action_just_pressed("menu"):
		if menu:
			self.visible = true
			menu = false
		else: 
			self.visible = false
			menu = true
			
	if mic_value >= mic_slider:
		emit_signal("talk_volume_reached")
		if mic_value >= scream_slider:
			screaming = true
	if decay_value.value > time_slider:
		talking = true
	else:
		talking = false
		screaming = false

#func _on_volume_input_value_changed(value):
	#mic_input = value
	#print(mic_input)

func _on_volume_selection_value_changed(value):
	mic_slider = value
	#print(mic_slider)

func _on_time_selection_value_changed(value):
	time_slider = value
	#print(time_slider)

#func _on_decay_bar_value_changed(value):
	#decay_value = value

func _on_scream_selection_value_changed(value):
	scream_slider = value


func _on_area_2d_mouse_entered():
	print("entered")
