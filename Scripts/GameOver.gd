extends CanvasLayer



func _on_IntentarDeNuevo_pressed():
	get_tree().change_scene("res://Niveles/Nivel1.tscn")


func _on_Salir_pressed():
	get_tree().quit()
