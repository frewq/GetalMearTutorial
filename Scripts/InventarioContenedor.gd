extends NinePatchRect

func _ready():
	visible = false
	
func colectar_botin():
	visible = true
	$Inventario.add_icon_item(load(Global.naletin_Sprite), false)