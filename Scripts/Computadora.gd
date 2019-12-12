extends Area2D

var puede_clickear = false
var combinacion

export var combinacion_largo = 4
export var cerradura_grupo = "Sin especificar"

signal combinacion

func _ready():
	$Light2D.enabled = false
	generar_combinacion()
	emit_signal("combinacion", combinacion, cerradura_grupo)
	$Label.rect_rotation = -rotation_degrees #siempre va a quedar en el mismo ángulo
	$Label.text = cerradura_grupo
	
func generar_combinacion():
	var generador_combinacion = get_tree().get_root().find_node("GeneradorCombinaciones", true, false)
	combinacion = generador_combinacion.generador_combinacion(combinacion_largo)
	set_popup_texto()

func _on_Computadora_body_entered(body):
	puede_clickear = true


func _on_Computadora_body_exited(body):
	puede_clickear = false
	$Light2D.enabled = false
	$CanvasLayer/ComputadoraPopup.hide()

func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and puede_clickear:
		$CanvasLayer/ComputadoraPopup.popup_centered()
		$Light2D.enabled = true
		
func set_popup_texto():
	$CanvasLayer/ComputadoraPopup.set_text(combinacion)