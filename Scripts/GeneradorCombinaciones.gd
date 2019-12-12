extends Node

func generador_combinacion(largo):
	var combinacion = []
	for numero in range(largo):
		randomize()
		combinacion.append(randi() % 10)
	return combinacion
	