extends Button

@export var _level_number: int
@onready var _level_scene_path: String = "res://src/Levels/Level_" + str(_level_number) + ".tscn"

func _ready() -> void:
	disabled = PlayerData.get_levels_unlocked() < _level_number
	$LevelLockedIcon.visible = disabled
	text = str(_level_number)
	# connect("button_up", _on_button_up)
	if _level_number == 1:
		print(get_signal_connection_list("button_up"))
		print("-------------------")

func _on_button_up() -> void:
	print("button", _level_number)
	get_tree().change_scene_to_packed(load(_level_scene_path))
