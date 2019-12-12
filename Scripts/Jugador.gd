extends "res://Scripts/Caracter.gd"

var movimiento = Vector2()
enum modos_vision {OSCURO, VISION_NOCTURNA}
var modo_vision
var vision_cambio_cooldown = false
var disfrazado = false

func _ready():
	Global.Jugador = self
	modo_vision = modos_vision.OSCURO
	collision_layer = 16

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
	
	if Input.is_action_just_pressed("ui_cambiar_modo_vision") and not vision_cambio_cooldown:
		cambiar_modo_vision()
		vision_cambio_cooldown = true
		$ModoVisionReloj.start()
		
	if Input.is_action_just_pressed("conmutar_disfraz"):
		conmutar_disfraz()

func conmutar_foco():
	if $Foco.enabled:
		$Foco.enabled = false
	else:
		$Foco.enabled = true

func cambiar_modo_vision():
	if modo_vision == modos_vision.OSCURO:
		get_tree().call_group("interface", "visionNocturna")
		modo_vision = modos_vision.VISION_NOCTURNA
	elif modo_vision == modos_vision.VISION_NOCTURNA:
		get_tree().call_group("interface", "visionOscura")
		modo_vision = modos_vision.OSCURO


func _on_ModoVisionReloj_timeout():
	vision_cambio_cooldown = false

func conmutar_disfraz():
	if disfrazado:
		revelar()
	else:
		disfraz()
	
func revelar():
	$Sprite.texture = load(Global.jugador_sprite)
	$Light2D.texture = load(Global.jugador_sprite)
	$LightOccluder2D.occluder = load(Global.jugador_oclusor)
	collision_layer = 1
	disfrazado = false
	
func disfraz():
	$Sprite.texture = load(Global.caja_sprite)
	$Light2D.texture = load(Global.caja_sprite)
	$LightOccluder2D.occluder = load(Global.caja_oclusor)
	collision_layer = 16
	disfrazado = true
