@tool
extends Button

@export var _scene_path: String


func _on_button_up() -> void:
	SceneManager.change_scene(_scene_path)


func _get_configuration_warnings() -> PackedStringArray:
	return ["scene_path property can't be empty"] if not _scene_path else []
