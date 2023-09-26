@tool
extends Button

@export var scene_path: String


func _ready() -> void:
	print(get_signal_connection_list("button_up"))


func _on_button_up() -> void:
	get_tree().change_scene_to_packed(load(scene_path))


func _get_configuration_warnings() -> PackedStringArray:
	return ["scene_path property can't be empty"] if not scene_path else []
