extends Node


func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_packed(load(scene_path))
