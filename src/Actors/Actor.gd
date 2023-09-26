class_name Actor extends CharacterBody2D

@export var gravity: float = 3000.0
@export var speed := Vector2(500.0, 1300.0)


func add_gravity() -> void:
	velocity.y += gravity * get_physics_process_delta_time()
