extends "res://Scripts/Puerta.gd"

var combinacion

func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and puede_hacer_click:
		$CanvasLayer/PadNumerico.popup_centered()

func _on_Puerta_body_exited(body):
	if body == Global.Jugador:
		puede_hacer_click = false
		$CanvasLayer/PadNumerico.hide()
		$CanvasLayer/PadNumerico.reiniciar_cerradura()

func _on_PadNumerico_combinacion_correcta():
	abrir()


func _on_Computadora_combinacion(numeros, cerradura_grupo):
	combinacion = numeros
	$CanvasLayer/PadNumerico.combinacion = combinacion
	$Label.rect_rotation = -rotation_degrees #siempre va a quedar en el mismo ángulo
	$Label.text = cerradura_grupo


func _on_DetectarSalida_body_entered(body):
	abrir()
