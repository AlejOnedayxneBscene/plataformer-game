extends Node2D
var points_label
var texture_progress_bar
var puntos = 0

func _ready():
	points_label = get_node("/root/ui/Panel/PointsLabel")
	texture_progress_bar = get_node("/root/ui/TextureRect2/TextureProgressBar")

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
