class_name PilotUI
extends Control

enum Gauges {FUEL, SHIELDS}
@onready var gauge_panel: VBoxContainer = get_node("Gauges")
@onready var craft: Spacecraft = get_parent().get_node("Spacecraft")

func _ready() -> void:
	reset_gauges()

func update_gauge(gauge: int, value: float) -> void:
	var target: ProgressBar
	if gauge == Gauges.FUEL:
		target = gauge_panel.get_node("FuelBar")
		target.value += value
	else:
		target = gauge_panel.get_node("ShieldBar")
		target.value += value


func reset_gauges() -> void:
	var gauge = gauge_panel.get_node("FuelBar")
	gauge.value = craft.stats.max_fuel
	gauge.max_value = craft.stats.max_fuel
	
	gauge = gauge_panel.get_node("ShieldBar")
	gauge.value = craft.stats.max_fuel
	gauge.max_value = craft.stats.max_shields
