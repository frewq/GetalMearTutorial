extends Area2D



func _on_Maletin_body_entered(body):
	Global.Jugador.colectar_maletin()
	queue_free()
