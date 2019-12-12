extends TextureProgress

var sospecha = 0
export var sospecha_aumenta = 3 #cuanta sospecha aumenta cuando nos ven
export var sospecha_cae = 0.25 #cuanta sospecha disminuye

func _process(delta):
	sospecha -= sospecha_cae
	sospecha = clamp(sospecha, 0, max_value) #clamp es una alternativa al if, de mejor rendimiento
	value = sospecha


func jugador_visto():
	sospecha += sospecha_aumenta
	if sospecha >= max_value:
		fin_juego()

func fin_juego():
	get_tree().quit()