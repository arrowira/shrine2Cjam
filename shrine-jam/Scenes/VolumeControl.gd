extends HSlider

@export var bus_name: String = "Master"

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	var current_volume_db = AudioServer.get_bus_volume_db(bus_index)
	value = db_to_linear(current_volume_db)

func _on_value_changed(slider_value: float) -> void:
	var volume_db = linear_to_db(slider_value)
	AudioServer.set_bus_volume_db(bus_index, volume_db)
