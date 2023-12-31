extends Control

var paused := false:
	set = set_paused
@onready var _scene_tree := get_tree() as SceneTree
@onready var _pause_overlay := $PauseOverlay as ColorRect
@onready var _score_label := $Score as Label
@onready var _pause_title := $PauseOverlay/Title as Label


func _ready() -> void:
	paused = false
	PlayerData.connect("score_updated", _update_interface)
	PlayerData.connect("player_died", _on_PlayerData_player_died)
	_update_interface()


func _on_PlayerData_player_died() -> void:
	_pause_title.text = "You died!"
	paused = true


func _on_retry_button_up() -> void:
	PlayerData.reset_score()
	paused = false
	_scene_tree.reload_current_scene()


func _on_resume_button_up() -> void:
	paused = false


func _update_interface() -> void:
	_score_label.text = "Score: %s" % PlayerData.get_score()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		paused = not paused
		get_viewport().set_input_as_handled()


func set_paused(value: bool) -> void:
	paused = value
	_scene_tree.paused = value
	_pause_overlay.visible = value
