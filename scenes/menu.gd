extends Node2D
var ui_node

func _ready():
	ui_node = get_node("/root/ui")
	ui_node.hide()

func _exit_tree():
	ui_node.show()

func _on_button_pressed_level1() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_2_pressed_level2() -> void:
	get_tree().change_scene_to_file("res://scenes/nivel2.tscn")
