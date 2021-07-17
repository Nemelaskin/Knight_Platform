extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 200
var gravity = 1800.0
var radius_see = 100
var check 
var dir = 0


func _physics_process(delta):
	move_enemy(delta)

func move_enemy(delta):
	$RayCast2D.cast_to.x = 33*dir
	velocity.y += gravity * delta
	
	if global_position.distance_to(Global.Player.global_position) <= radius_see && (Global.Player.global_position.y-40 <= global_position.y &&  Global.Player.global_position.y+40 >= global_position.y):
		to_player_way()
		velocity.x = dir * speed
	
	if $RayCast2D.is_colliding() or not check:
		random_way()
		velocity.x = dir * speed
		check = 1
	
	velocity = move_and_slide(velocity)


func random_way():
	var temp = randi() % 2 
	if temp == 0:
		dir = -1
	else: 
		dir = 1

func to_player_way():
	if Global.Player.global_position <= global_position:
		dir = -1
	else:
		dir = 1

func to_ray(whence, where):
	var space = get_world_2d().direct_space_state
	var result = space.intersect_ray(whence, where, [self])
	if result and result.collider == Global.Player: #global.player = where
		return true
	else:
		return false
