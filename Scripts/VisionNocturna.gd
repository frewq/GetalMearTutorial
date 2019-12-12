extends CanvasModulate

var OSCURO = Color("104691")
var VISION_NOCTURNA = Color("20ff00")

func _ready():
	add_to_group("interface")
	color = OSCURO

func visionNocturna():
	inform_npc("mode_VisionNocturna")
	color = VISION_NOCTURNA
	$AudioStreamPlayer.stream = load(Global.visionnocturna_sonido_on)
	play_sonido()

func visionOscura():
	inform_npc("mode_VisionOscura")
	color = OSCURO
	$AudioStreamPlayer.stream = load(Global.visionnocturna_sonido_off)
	play_sonido()
	
func play_sonido():
	$AudioStreamPlayer.play()
	
func inform_npc(mode_vision):
	get_tree().call_group("npc", mode_vision)