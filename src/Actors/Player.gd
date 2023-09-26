class_name Player extends Actor

const Y_direction := {JUMP = -1.0, FALL = 1.0}
@export var _stomp_impulse: float = 500.0
@export var _coyote_time: float = 0.2
var _coyote_timer: float = 0.0
var _has_jumped := false
var _has_double_jumped := false


func _on_enemy_detector_area_entered(_area: Area2D) -> void:
	velocity = _calc_stomp_velocity(_stomp_impulse)
	$EnemyKilledSound.play()


func _on_enemy_detector_body_entered(_body: Node2D) -> void:
	_die()


func _physics_process(delta: float) -> void:
	add_gravity()
	_calc_coyote_time(delta)
	var is_jump_interrupted: bool = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: Vector2 = _get_direction()

	velocity = _calc_velocity(velocity, direction, is_jump_interrupted)
	move_and_slide()


func _get_direction() -> Vector2:
	var x_axis: float = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	var y_axis: float = _handle_jump()

	return Vector2(x_axis, y_axis)


func _handle_jump() -> float:
	if Input.is_action_just_pressed("jump"):
		if _coyote_timer < _coyote_time and not _has_jumped:
			_has_jumped = true
			return Y_direction.JUMP
		elif _has_jumped and not _has_double_jumped:
			_has_double_jumped = true
			return Y_direction.JUMP
		else:
			return Y_direction.FALL
	else:
		return Y_direction.FALL


func _calc_velocity(
	linear_velocity: Vector2, direction: Vector2, is_jump_interrupted: bool
) -> Vector2:
	var out: Vector2 = linear_velocity
	out.x = speed.x * direction.x

	if direction.y == Y_direction.JUMP:
		out.y = speed.y * direction.y

	if is_jump_interrupted:
		out.y = -250.0

	return out


func _calc_stomp_velocity(impulse: float) -> Vector2:
	var out: Vector2 = velocity
	out.y = -impulse
	return out


func _calc_coyote_time(delta: float) -> void:
	if is_on_floor():
		_coyote_timer = 0.0
		_has_jumped = false
		_has_double_jumped = false
	else:
		_coyote_timer += delta


func _die() -> void:
	PlayerData.set_death_count()
