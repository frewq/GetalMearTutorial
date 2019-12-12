extends CanvasModulate

var OSCURO = Color("104691")
var VISION_NOCTURNA = Color("20ff00")

func _ready():
	add_to_group("interface")
	color = OSCURO
	get_tree().call_group("Etiquetas", "hide")

func visionNocturna():
	inform_npc("mode_VisionNocturna")
	color = VISION_NOCTURNA
	$AudioStreamPlayer.stream = load(Global.visionnocturna_sonido_on)
	play_sonido()
	get_tree().call_group("Etiquetas", "show")
	get_tree().call_group("Lampara_jugador", "hide")

func visionOscura():
	inform_npc("mode_VisionOscura")
	color = OSCURO
	$AudioStreamPlayer.stream = load(Global.visionnocturna_sonido_off)
	play_sonido()
	get_tree().call_group("Etiquetas", "hide")
	get_tree().call_group("Lampara_jugador", "show")
	
func play_sonido():
	$AudioStreamPlayer.play()
	
func inform_npc(mode_vision):
	get_tree().call_group("npc", mode_vision)