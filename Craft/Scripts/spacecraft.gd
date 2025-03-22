class_name Spacecraft
extends Area3D

@export var stats: Ship
@export var current_mesh: MeshInstance3D

@onready var fuel: float = stats.max_fuel

@onready var parent: Node3D = get_parent()
@onready var mesh: MeshInstance3D = get_node("MeshInstance3D")

var ui: PilotUI
var throttle: float = 0.0
var max_throttle: float = 20.0
var velocity: Vector3

func _ready() -> void:
	mesh = current_mesh
	if parent is Player:
		ui = parent.get_node("PilotUI")

func _physics_process(delta: float) -> void:
	drain_fuel(stats.economy * throttle)
	if throttle < 0.0:
		throttle = 0.0
	if throttle > max_throttle:
		throttle = max_throttle
	if throttle == 0.0:
		velocity = velocity.move_toward(Vector3.ZERO, stats.decel * delta)
	if throttle > 0.0:
		var velocity_mod = throttle * stats.accel
		velocity += (basis.z * velocity_mod) * delta
	move()
	update_telem(ui.Telemetry.VELOCITY, velocity.length())
	update_telem(ui.Telemetry.THROTTLE, throttle)

func drain_fuel(value: float) -> void:
	fuel -= value
	ui.update_gauge(0, -value)

func move() -> void:
	if velocity.length() > stats.max_velocity:
		velocity = velocity.normalized() * stats.max_velocity
	position += velocity

func update_telem(telem: int, value: float) -> void:
	ui.update_telemetry(telem, value)
