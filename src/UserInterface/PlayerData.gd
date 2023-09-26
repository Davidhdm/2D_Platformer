extends Node

signal score_updated
signal player_died

var _score: int = 0:
	get = get_score,
	set = set_score

var _death_count: int = 0:
	get = get_death_count,
	set = set_death_count

var _levels_unlocked: int = 2:
	get = get_levels_unlocked,
	set = set_levels_unlocked


func get_score() -> int:
	return _score


func set_score(value: int) -> void:
	if value == 0:
		_score = value
	else:
		_score += value

	score_updated.emit()


func reset_score() -> void:
	_score = 0


func get_death_count() -> int:
	return _death_count


func set_death_count(value = null) -> void:
	if value == 0:
		_death_count = 0
	else:
		_death_count += 1
		player_died.emit()


func reset_death_count() -> void:
	_death_count = 0


func get_levels_unlocked() -> int:
	return _levels_unlocked


func set_levels_unlocked(value: int) -> void:
	_levels_unlocked = value
