extends Node

var max_health: float
var current_health: float

var damageable := true

signal reached_zero_health
signal health_change

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func damage(amount: float) -> void:
	if damageable:
		current_health = clamp(current_health - amount, 0.0, max_health)
		health_change.emit()
		if current_health == 0.0:
			reached_zero_health.emit()

# pls dont call with negative values
func heal(amount: float) -> void:
	current_health = clamp(current_health + amount, 0.0, max_health)
	health_change.emit()
