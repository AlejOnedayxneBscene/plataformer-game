extends Node2D

func _on_button_pressed_level1() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_button_2_pressed_level2() -> void:
	get_tree().change_scene_to_file("res://nivel2.tscn")
