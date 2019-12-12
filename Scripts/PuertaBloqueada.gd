extends "res://Scripts/Puerta.gd"

var combinacion = [4,1,5,5]

func _ready():
	$CanvasLayer/PadNumerico.combinacion = combinacion

func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and puede_hacer_click:
		print("hola")
		$CanvasLayer/PadNumerico.popup_centered()

func _on_Puerta_body_exited(body):
	if body == Global.Jugador:
		puede_hacer_click = false
		$CanvasLayer/PadNumerico.hide()

func _on_PadNumerico_combinacion_correcta():
	abrir()
