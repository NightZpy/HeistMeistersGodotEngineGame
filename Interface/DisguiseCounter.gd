extends ItemList


func update_disguises(disguise_quantity):
	clear()
	
	for disguise in range(disguise_quantity):
		add_icon_item(load("res://GFX/PNG/Tiles/tile_129.png"), false)