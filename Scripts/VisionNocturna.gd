extends CanvasModulate

var OSCURO = Color("104691")
var VISION_NOCTURNA = Color("20ff00")

func _ready():
	add_to_group("interface")
	color = OSCURO

func visionNocturna():
	color = VISION_NOCTURNA

func visionOscura():
	color = OSCURO
	
