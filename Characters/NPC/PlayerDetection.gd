extends "res://Characters/TemplateCharacter.gd"

# POINT_OF_VIEW = POV
const FOV_TOLERANCE = 20
const MAX_DETECTION_DISTANCE = 640
const RED = Color(Color.red)
const WHITE = Color(Color.white)
var Player


func _ready():
	Player = get_node("/root").find_node("Player", true, false)
	

func _process(delta):
	if Player_in_FOV() and Player_in_LOS():
		$Torch.set_color(RED)
	else:
		$Torch.set_color(WHITE)
		

func Player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()
	
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	
	return false
	
	
func Player_in_LOS():
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	
	if not LOS_obstacle or not LOS_obstacle.collider.name == 'Player':
		return false
	
	var distance_to_player = Player.global_position.distance_to(global_position)
	
	return LOS_obstacle.collider == Player and distance_to_player <= MAX_DETECTION_DISTANCE
