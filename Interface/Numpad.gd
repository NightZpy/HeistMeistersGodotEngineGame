extends Popup

var combination = [0, 4, 5, 1]
var guess = []

onready var display = $VBoxContainer/DisplayContainer/Display
onready var light = $VBoxContainer/ButtonContainer/GridContainer/StatusLight
onready var status_light_bad_texture = load("res://GFX/Interface/PNG/dotRed.png")
onready var status_light_ok_texture = load("res://GFX/Interface/PNG/dotGreen.png")
signal right_combination


func _ready():
	connect_buttons()

	
func connect_buttons():
	for grid_button in $VBoxContainer/ButtonContainer/GridContainer.get_children():
		if grid_button is Button:
			grid_button.connect("pressed", self, "Button_pressed", [grid_button.text])
	
		
func Button_pressed(button):
	if button == "ok":
		check_combination()
	else:
		append_guess_number(int(button))
	
	
func check_combination():
	if guess == combination:
		$AudioStreamPlayer.stream = load("res://SFX/threeTone1.ogg")
		$AudioStreamPlayer.play()
		light.texture = status_light_ok_texture
		$Timer.start()
	else:
		reset_lock()

	
func append_guess_number(button):
	$AudioStreamPlayer.stream = load("res://SFX/twoTone1.ogg")
	$AudioStreamPlayer.play()
	guess.append(button)
	update_display()
	
	if guess.size() == combination.size():
		check_combination()

	
func update_display():
	display.text = PoolStringArray(guess).join("-")

	
func reset_lock():
	display.text = ""
	light.texture = status_light_bad_texture
	guess.clear()
	


func _on_Timer_timeout():
	emit_signal("right_combination")
	reset_lock()
