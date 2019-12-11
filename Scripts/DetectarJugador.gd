extends "res://Scripts/Caracter.gd"

const FOV_TOLERANCIA = 20
const MAXIMO_RANGO_DETECCION = 200
const ROJO = Color(1, 0.25, 0.25)
const WHITE = Color (1,1,1)

onready var Jugador = get_node("/root/Nivel1/Jugador")

func _process(delta):
	if Jugador_esta_en_FOV_Tolerancia() and Jugador_a_la_vista():
		$Foco.color = ROJO
	else:
		$Foco.color = WHITE
	
func Jugador_esta_en_FOV_Tolerancia():
	var NPC_mira_direccion = Vector2(1,0).rotated(global_rotation)
	var direccion_al_Jugador = (Jugador.position - global_position).normalized()
	
	if abs(direccion_al_Jugador.angle_to(NPC_mira_direccion)) < deg2rad(FOV_TOLERANCIA):
		return true
	else:
		return false
		
func Jugador_a_la_vista():
	var espacio = get_world_2d().direct_space_state
	var vista_obstaculo = espacio.intersect_ray(global_position, Jugador.global_position, [self], collision_mask)
	
#	Evita que se congele el juego de manera aleatoria al ser detectado por la cámara:
	if not vista_obstaculo:
		return false
	
	var distancia_al_jugador = Jugador.global_position.distance_to(global_position)
	var Jugador_en_rango = (distancia_al_jugador < MAXIMO_RANGO_DETECCION)
	
	if (vista_obstaculo.collider == Jugador) and Jugador_en_rango:
		return true
	else:
		return false