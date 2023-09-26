@tool
class_name Portal2D
extends Area2D

@export var scene_path: String
@onready var _animator := $AnimationPlayer as AnimationPlayer


func _get_configuration_warnings() -> PackedStringArray:
	return ["scene_path property can't be empty"] if not scene_path else []


func _teleport() -> void:
	_animator.play("fade_in")
	await _animator.animation_finished
	get_tree().change_scene_to_packed(load(scene_path))


func _on_body_entered(_body: Node2D) -> void:
	_teleport()
