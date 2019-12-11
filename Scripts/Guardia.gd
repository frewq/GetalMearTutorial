extends "res://Scripts/DetectarJugador.gd"

var movimiento = Vector2()
var destinos_posibles = []
var camino = []
var destino = Vector2()

export var relentizar_caminata = 0.5
export var nav_parar_limite = 5

onready var navegacion = Global.navegacion
onready var destinos_habilitados = Global.destinos

func _ready():
	destinos_posibles = destinos_habilitados.get_children()
	hacer_camino()
	
func _process(delta):
	navegar()

func navegar():
	var distancia_a_destino = position.distance_to(camino[0])
	destino = camino[0]
	
	if distancia_a_destino > nav_parar_limite:
		mover()
	else:
		actualizar_camino()

func mover():
	look_at(destino)
	movimiento = (destino - position).normalized() * (MAXIMA_VELOCIDAD * relentizar_caminata)
	
	if is_on_wall():
		hacer_camino()
	
	move_and_slide(movimiento)

func actualizar_camino():
	if camino.size() == 1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		camino.remove(0)

func hacer_camino():
	randomize()
	var siguiente_destino = destinos_posibles[randi() % destinos_posibles.size()]
	
	camino = navegacion.get_simple_path(global_position, siguiente_destino.global_position, false)

func _on_Timer_timeout():
	hacer_camino()
