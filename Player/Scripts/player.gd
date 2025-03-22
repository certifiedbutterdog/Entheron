class_name Player
extends Node3D

@onready var craft: Spacecraft = get_node("Spacecraft")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("forward"):
		craft.throttle += delta * craft.stats.accel
	if Input.is_action_pressed("left"):
		craft.rotate_object_local(Vector3.UP, craft.velocity.length() * delta)
	if Input.is_action_pressed("right"):
		craft.rotate_object_local(Vector3.DOWN, craft.velocity.length() * delta)
	if Input.is_action_pressed("up"):
		craft.rotate_object_local(Vector3.LEFT, craft.velocity.length() * delta)
	if Input.is_action_pressed("down"):
		craft.rotate_object_local(Vector3.RIGHT, craft.velocity.length() * delta)
