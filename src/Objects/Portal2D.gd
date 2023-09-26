@tool
class_name Portal2D
extends Area2D

@export var _scene_path: String
@export var _current_level: int
@onready var _animator := $AnimationPlayer as AnimationPlayer


func _get_configuration_warnings() -> PackedStringArray:
	return (
		["scene_path property can't be empty"]
		if not _scene_path
		else ["current_level property can't be empty"] if not _current_level else []
	)


func _teleport() -> void:
	_animator.play("fade_in")
	await _animator.animation_finished
	SceneManager.change_scene(_scene_path)


func _on_body_entered(_body: Node2D) -> void:
	var unlock_level: int = _current_level + 1
	if unlock_level > PlayerData.get_levels_unlocked():
		PlayerData.set_levels_unlocked(unlock_level)
	_teleport()
