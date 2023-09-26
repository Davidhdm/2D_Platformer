extends Button

@export var _level_number: int
@onready var _level_scene_path: String = "res://src/Levels/Level_" + str(_level_number) + ".tscn"


func _ready() -> void:
	disabled = PlayerData.get_levels_unlocked() < _level_number
	$LevelLockedIcon.visible = disabled


func _on_button_up() -> void:
	SceneManager.change_scene(_level_scene_path)
