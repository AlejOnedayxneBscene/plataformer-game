extends Area2D

func _on_body_entered(body: Node2D) -> void:
		SingleGameManager.add_puntos()
		queue_free() # Esto elimina la cereza
