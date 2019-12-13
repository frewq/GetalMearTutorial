extends "res://Scripts/Caracter.gd"

export var disfraces = 3 #cantidad de disfraces con la se comienza
export var disfraz_duracion = 5 #tiempo que dura el disfraz
export var disfraz_relentizamiento = 0.25

var movimiento = Vector2()
enum modos_vision {OSCURO, VISION_NOCTURNA}
var modo_vision
var vision_cambio_cooldown = false
var disfrazado = false
var velocidad_multiplicador = 1

func _ready():
	Global.Jugador = self
	modo_vision = modos_vision.OSCURO
#	collision_layer = 1
	$Timer.wait_time = disfraz_duracion
	actualizar_disfraces_pantalla()
	revelar()

func _process(delta):
	actualizar_movimiento(delta)
	move_and_slide(movimiento * velocidad_multiplicador)
	if disfrazado:
		$Label.rect_rotation = -rotation_degrees
		$Label.text = str($Timer.time_left).pad_decimals(2)
	
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
	elif disfraces > 0:
		disfraz()
	
func revelar():
	$Label.visible = false
	$Sprite.texture = load(Global.jugador_sprite)
	$Light2D.texture = load(Global.jugador_sprite)
	$LightOccluder2D.occluder = load(Global.jugador_oclusor)
	collision_layer = 1
	
	velocidad_multiplicador = 1
	
	disfrazado = false
	
func disfraz():
	$Label.visible = true
	$Sprite.texture = load(Global.caja_sprite)
	$Light2D.texture = load(Global.caja_sprite)
	$LightOccluder2D.occluder = load(Global.caja_oclusor)
	collision_layer = 16
	
	velocidad_multiplicador = disfraz_relentizamiento
	$Timer.start()
	
	disfraces -= 1
	actualizar_disfraces_pantalla()
	disfrazado = true

func actualizar_disfraces_pantalla():
	get_tree().call_group("DisfracesPantalla", "actualizar_disfraces", disfraces)
	
func colectar_maletin():
	var botin = Node.new()
	botin.set_name("Maletin")
	add_child(botin)
	get_tree().call_group("interface", "colectar_botin")