extends Control


@onready var _total_score := $TotalScore as Label
@onready var _total_deaths := $DeathCount as Label


func _ready() -> void:
	_total_score.text %= PlayerData.get_score()
	_total_deaths.text %= PlayerData.get_death_count()