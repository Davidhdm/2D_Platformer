class_name Coin extends Area2D

@onready var _animator := $AnimationPlayer as AnimationPlayer
@onready var collider := $CollisionShape2D as CollisionShape2D
@onready var on_screen_enabler := $VisibleOnScreenEnabler2D as VisibleOnScreenEnabler2D
@export var _score: int = 10
static var bounce_timer: float

func _on_body_entered(_body: Node2D) -> void:
	_picked()

func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	_animator.play("bounce")
	_animator.seek(bounce_timer, false)

func _picked() -> void:
	# Remove Collider to avoid multiple collisions
	collider.queue_free() 
	# Remove VisibleOnScreenEnabler to prevent animation from being
	# interrupted if item gets out of the screen too fast, for example
	# if the player is falling when picking up the coin
	on_screen_enabler.queue_free()

	PlayerData.set_score(_score)
	_animator.play("fade_out")
	await _animator.animation_finished 
	queue_free()

static func update_timer(time: float) -> void:
	bounce_timer = time
