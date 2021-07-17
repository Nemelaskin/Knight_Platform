extends Node2D

class_name Room

var rect = Rect2()
var size_prj = Vector2()

func _ready():
	size_prj = get_viewport().size
	var  temp = get_node("Border")
	rect.position = temp.rect_global_position
	rect.size = temp.rect_size

func block_camera(var camera_pos):
	var left_cam = camera_pos.x - (size_prj.x/2)
	var right_cam = camera_pos.x + (size_prj.x/2)
	var left_rect = rect.position.x - (rect.size.x/2)
	var right_rect = rect.position.x + (rect.size.x/2)
	
	if left_cam < left_rect:
		camera_pos.x = left_rect + size_prj.x/2
	if right_cam > right_rect:
		camera_pos.x = right_rect - size_prj.x/2
	return camera_pos

func _draw():
	draw_rect(rect, Color (0,1,0), false)
	
