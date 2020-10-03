extends CanvasModulate

const DARK = Color('121412')
const MIST = Color('ea121412')
const NIGHT_VISION = Color('2eb236')

var cooldown = false

func _ready():
	visible = true
	color = DARK
	add_to_group("Interface")
	
func cycle_vision_mode():
	if not cooldown:
		if color == NIGHT_VISION:
			mist_mode()
		else:
			night_vision_mode()
		cooldown = true
		$CooldownSwitch.start()

func dark_mode():
	color = DARK
	turn_off_night_vision_mode_sound()
	get_tree().call_group('lights', 'show')
	get_tree().call_group('labels', 'hide')

func mist_mode():
	color = MIST
	turn_off_night_vision_mode_sound()
	get_tree().call_group('lights', 'show')
	get_tree().call_group('labels', 'hide')
	
func night_vision_mode():
	color = NIGHT_VISION
	turn_on_night_vision_mode_sound()
	get_tree().call_group('lights', 'hide')
	get_tree().call_group('labels', 'show')
	
func turn_off_night_vision_mode_sound(): 	
	play_audio("res://SFX/nightvision_off.wav")	

func turn_on_night_vision_mode_sound():	
	play_audio("res://SFX/nightvision.wav")	
	
func play_audio(audio_path: String):	
	$AudioStreamPlayer2D.stream = load(audio_path)
	$AudioStreamPlayer2D.play()
	$CooldownSwitch.start()

func _on_CooldownSwitch_timeout():
	cooldown = false
