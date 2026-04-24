extends Node2D
@onready var points_label = $"../ui/Panel/PointsLabel"
@onready var texture_progress_bar = $"../ui/TextureRect2/TextureProgressBar2"
var puntos = 0
func add_puntos():
	puntos += 1
	print("Puntos:", puntos)

	if points_label:
		points_label.text = ": " + str(puntos)
	else:
		print("Label es null")
	if texture_progress_bar:
		texture_progress_bar.value += 1
		print("Barra:", texture_progress_bar.value)
	else:
		print("ProgressBar es null")
