extends Node2D

var texto

func _ready():
	add_to_group("interface")
	texto = get_json()
	actualizar_posicion_puntero(0)
	$GuiTutorial/Popup.show()
	
func get_json():
	var archivo = File.new()
	archivo.open(Global.mensajes_tutorial, archivo.READ)
	var contenido = archivo.get_as_text()
	archivo.close()
	return parse_json(contenido)

func actualizar_posicion_puntero(numero):
	var puntero = $PunteroObjetivo
	var marcador = $MarcadorObjetivos.get_child(numero)
#	puntero.position = marcador.position
	
	$Tween.interpolate_property(puntero, "position", puntero.position, marcador.position, 0.5,Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	
#	$MarcadorObjetivos.remove_child(marcador)
	$AudioStreamPlayer.play()
	$GuiTutorial/AnimationPlayer.play("MensajeTransicion")
	$GuiTutorial/Popup/Label.text = texto[str(numero)]

func _on_ObjetivoMovimiento_body_entered(body):
	actualizar_posicion_puntero(1)

func _on_ObjetivoPuerta_body_entered(body):
	actualizar_posicion_puntero(2)


func _on_ObjetivoVisionNocturna_body_entered(body):
	actualizar_posicion_puntero(3)
	visionOscura()


func _on_Maletin_body_entered(body):
	actualizar_posicion_puntero(4)

func visionOscura():
	$GuiTutorial/Popup.show()

func visionNocturna():
	$GuiTutorial/Popup.hide()