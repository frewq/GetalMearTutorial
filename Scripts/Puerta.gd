extends Area2D

var puede_hacer_click = false

func _on_Puerta_body_entered(body):
	if not body == Global.Jugador and not $AnimationPlayer.is_playing():
		abrir()
	else:
		puede_hacer_click = true


func _on_Puerta_body_exited(body):
	if body == Global.Jugador:
		puede_hacer_click = false

func abrir():
	if not $AnimationPlayer.is_playing():
		 $AnimationPlayer.play("abrir")

func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and puede_hacer_click:
		abrir()