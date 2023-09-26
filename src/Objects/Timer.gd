extends Timer

var _animation_time: float = 1.2

func _physics_process(_delta: float) -> void:
	Coin.update_timer(_animation_time - time_left)
