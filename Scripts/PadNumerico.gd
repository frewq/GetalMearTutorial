extends Popup

onready var pantalla = $VSplitContainer/CenterContainer/Pantalla
onready var luz = $VSplitContainer/BotonContenedor/GrillaBotones/Luz

var combinacion = []
var adivinar = []

signal combinacion_correcta

func _ready():
	conectar_botones()
	reiniciar_cerradura()

func conectar_botones():
	for hijo in $VSplitContainer/BotonContenedor/GrillaBotones.get_children():
		if hijo is Button:
			hijo.connect("pressed", self, "botonPresionado", [hijo.text])

func botonPresionado(boton):
	if boton == "OK":
		comprobar()
	else:
		entrar(int(boton))

func comprobar():
	if adivinar == combinacion:
		$AudioStreamPlayer.stream = load("res://SFX/threeTone1.ogg")
		$AudioStreamPlayer.play()
		luz.texture = load(Global.luz_verde)
		$Timer.start()
	else:
		reiniciar_cerradura()

func entrar(boton):
	$AudioStreamPlayer.stream = load("res://SFX/twoTone1.ogg")
	$AudioStreamPlayer.play()
	adivinar.append(boton)
#	print(adivinar.size())
	actualizar_display()

func reiniciar_cerradura():
	luz.texture = load(Global.luz_roja)
	pantalla.clear() #igual que el bbcode
	adivinar.clear()

func actualizar_display():
	pantalla.bbcode_text = "[center]" + PoolStringArray(adivinar).join("") + "[/center]"
	if adivinar.size() == combinacion.size():
		comprobar()

func _on_Timer_timeout():
	emit_signal("combinacion_correcta")
	hide()
	reiniciar_cerradura()