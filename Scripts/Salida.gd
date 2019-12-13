extends ColorRect



func _on_Area2D_body_entered(body):
	if body.has_node("Maletin"):
		get_tree().change_scene("res://Escenas/Victoria.tscn")
#		print("completo")
