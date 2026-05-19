extends Node2D

@onready var cherry = load("res://scenes/collectible.tscn")
var timer 

func _ready():
	timer = get_node("Timer")
	timer.stop()
	timer.wait_time = randf_range(3, 5)
	timer.start()
	
func spawn():
	var inst = cherry.instantiate()
	add_child(inst)

func _on_timer_timeout() -> void:
	spawn()
	pass # Replace with function body.
