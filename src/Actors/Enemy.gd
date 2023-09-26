class_name Enemy extends Actor

@export var _score: int = 100


func _ready() -> void:
	velocity.x = -speed.x


func _on_stomp_detector_body_entered(body: Node2D) -> void:
	var player_y: float = body.global_position.y
	var enemy_y: float = $StompDetector.global_position.y

	if player_y > enemy_y:
		return

	die()


func _physics_process(_delta: float) -> void:
	add_gravity()
	if velocity.x == 0:
		velocity.x = -speed.x

	if is_on_wall():
		velocity.x = -velocity.x

	move_and_slide()


func die() -> void:
	PlayerData.set_score(_score)
	queue_free()
