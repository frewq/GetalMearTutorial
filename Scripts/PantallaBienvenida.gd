extends CanvasLayer


func _on_ButtonTutorial_pressed():
	get_tree().change_scene("res://Niveles/Tutorial.tscn")

func _on_ButtonHistoria_pressed():
	get_tree().change_scene("res://Niveles/Nivel1.tscn")

func _on_ButtonSalir_pressed():
	get_tree().quit()
