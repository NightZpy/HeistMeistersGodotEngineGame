extends "res://Doors/Door.gd"

func _ready():
	#generate_combination()
	$Label.rect_rotation = -rotation_degrees

func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/Numpad.popup_centered()
		
func _on_Door_body_exited(body):
	if body.collision_layer == 1:
		can_click = false
		$CanvasLayer/Numpad.hide()


func _on_Numpad_right_combination():
	open()
	$CanvasLayer/Numpad.hide()

#func generate_combination():
#	var length = 4
#	var combination = CombinationGenerator.generate_with_fixed_length(length)
#	#var combination = CombinationGenerator.generate()
#	$CanvasLayer/Numpad.combination = combination
#	print( str(combination) )
	

func _on_Computer_combination(combination, lock_group):
	$CanvasLayer/Numpad.combination = combination
	$Label.text = lock_group
