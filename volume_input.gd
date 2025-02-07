extends ProgressBar

class_name Volume_Input

@export var vtuber: Vtuber

var record_bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	record_bus_index = AudioServer.get_bus_index("Record")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var sample = AudioServer.get_bus_peak_volume_left_db(record_bus_index, 0)
	var linear_sample = db_to_linear(sample)
	#print(linear_sample)
	
	value = linear_sample
	#print(value)
	#text = '%s db' % round(sample)


func _on_decay_timer_timeout():
	pass
