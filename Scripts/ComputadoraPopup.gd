extends Popup

func set_text(combinacion):
	$RichTextLabel.bbcode_text = "La clave de la puerta es " + PoolStringArray(combinacion).join("")