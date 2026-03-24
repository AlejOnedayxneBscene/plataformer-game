extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		game_manager.add_puntos()
		queue_free() # Esto elimina la cereza
