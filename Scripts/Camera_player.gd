extends Camera2D

class_name Camera_player

func _ready():
	current = true

func _process(delta):
	global_position = Global.Player.global_position
	#global_position = Global.current_room.block_camera(global_position)
