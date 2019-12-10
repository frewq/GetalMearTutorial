extends "res://Scripts/Caracter.gd"

var movimiento = Vector2()

func _process(delta):
	actualizar_movimiento(delta)
	move_and_slide(movimiento)
	
func actualizar_movimiento(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		movimiento.y = clamp((movimiento.y - VELOCIDAD), -MAXIMA_VELOCIDAD, 0)
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		movimiento.y = clamp((movimiento.y + VELOCIDAD), 0, MAXIMA_VELOCIDAD)
	else:
		movimiento.y = lerp(movimiento.y, 0, FRICCION)
		
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		movimiento.x = clamp((movimiento.x - VELOCIDAD), -MAXIMA_VELOCIDAD, 0)
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		movimiento.x = clamp((movimiento.x + VELOCIDAD), 0, MAXIMA_VELOCIDAD)
	else:
		movimiento.x = lerp(movimiento.x, 0, FRICCION)

func _input(event):
	if Input.is_action_just_pressed("ui_select"):
		conmutar_foco()

func conmutar_foco():
	if $Foco.enabled:
		$Foco.enabled = false
	else:
		$Foco.enabled = true
		