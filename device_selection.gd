extends OptionButton

var devices: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	devices = AudioServer.get_input_device_list()
	
	for i in range(devices.size()):
		var device =  devices[i]
		add_item(device)
		
		if device == AudioServer.get_input_device():
			select(i)
			
	item_selected.connect(_on_item_selected)
	
func _on_item_selected(index : int) -> void:
	AudioServer.set_input_device(devices[index])
	print(devices[index])
