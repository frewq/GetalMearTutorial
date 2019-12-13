extends ItemList

func actualizar_disfraces(numero):
	clear()
	for disfraces in range (numero):
		add_icon_item(load(Global.caja_sprite), false)