extends "res://Characters/TemplateCharacter.gd"

var motion = Vector2()

const PLAYER_SPRITE = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const PLAYER_OCCLUDER = "res://Characters/HumanOccluder.tres"
const PLAYER_LIGHT = "res://GFX/PNG/Hitman 1/hitman1_stand.png"

const BOX_SPRITE = "res://GFX/PNG/Tiles/tile_130.png"
const BOX_OCCLUDER = "res://Characters/BoxOccluder.tres"
const BOX_LIGHT = "res://GFX/PNG/Tiles/tile_130.png"

var disguise = false

func _physics_process(delta):
	update_movement()
	move_and_slide(motion)
	
func update_movement():
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
		
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)

func _input(event):
	if Input.is_action_just_released("switch_vision_mode"):
		turn_off_torch()
	
	if Input.is_action_just_pressed("Toggle_disguise"):
		toggle_disguise()	
	
func turn_off_torch():
	#$Torch.enabled = not $Torch.enabled
	get_tree().call_group("Interface", "cycle_vision_mode")
	

func toggle_disguise():
	if disguise:
		reveal()
	else:
		disguise()
		

func reveal():
	$Sprite.texture = load(PLAYER_SPRITE)
	$Light2D.texture = load(PLAYER_LIGHT)
	disguise = false
	collision_layer = 1
	$"LightOccluder2D".occluder = load(PLAYER_OCCLUDER)


func disguise():
	$Sprite.texture = load(BOX_SPRITE)
	$Light2D.texture = load(BOX_LIGHT)
	disguise = true
	collision_layer = 16
	$"LightOccluder2D".occluder = load(BOX_OCCLUDER)