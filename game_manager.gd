extends Node2D
@onready var points_label = $"../ui/Panel/PointsLabel"

var puntos = 0

func add_puntos():
	puntos += 1
	points_label.text = "Puntos: " + str(puntos)
	print(puntos)
