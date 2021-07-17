extends KinematicBody2D

var velocity = Vector2()
var dir = Vector2()
var speed = 700
var target = Vector2()
export var gravity = 1800

export var big_jump = 1200
var t_bool = false
var create = false

var check_drop = false

func check_mode():
	if Input.is_action_just_pressed("create_mode"):
		if create == false:
			create = true
			speed = 1200
		else:
			create = false
			speed = 300


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	check_mode()
	if create:
		creat_mode()
	else:
		if check_drop == false:
			get_input(delta)
	var t = 0.2
	if not is_on_floor() && t_bool:
		t = 0.01
	if is_on_floor():
		t_bool = false
	velocity.x = lerp(velocity.x, target.x, t)
	print(gravity * delta)
	velocity = move_and_slide(velocity, Vector2.UP)


func _ready():
	Global.Player = self

func creat_mode():
	dir = Vector2()
	if Input.is_action_pressed("move_left"):
		dir.x +=-1
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_up"):
		dir.y -= 1
	if Input.is_action_pressed("move_down"):
		dir.y += 1
	velocity = dir * speed

func get_input(delta):
	dir = Vector2()
	if Input.is_action_pressed("move_left"):
		dir.x +=-1
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	target.x = dir.x * speed

func _input(event):
	if event.is_action_pressed("jump") && is_on_floor():
		velocity.y -= big_jump

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy") && check_drop == false:
		check_drop = true
		drop_point(body.global_position)

func drop_point(point):
	var simp_dir = Vector2()
	if point.x <= global_position.x:
		simp_dir.x = 1
	else:
		simp_dir.x = -1
	simp_dir.y += -0.8
	velocity = simp_dir * 700
	yield(get_tree().create_timer(0.05), "timeout")
	check_drop = false
	t_bool = true
