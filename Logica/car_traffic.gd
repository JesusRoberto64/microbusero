extends CharacterBody3D

var engine_power = 8.0
var max_speed = 10.0
var stearig_angle = 25.0
var drag = 1.0
var tire_grip = 8.0
var gravity = 9.8

var floor_limit = 0.5

var is_march = true

@export var path_0 : Path3D
@export var path_1 : Path3D


var cur_lane = 0

var curve_0: Curve3D
var curve_1: Curve3D

var pos_offset = 5.0

var timer = 0.0

func _ready():
	stearig_angle = deg_to_rad(stearig_angle)
	curve_0 = path_0.curve
	curve_1 = path_1.curve

func _physics_process(delta):
	timer += delta
	var cur_path #= path_0
	var cur_curve #= curve_0
	if timer > 2.0:
		cur_path = path_1
		cur_curve = curve_1
	else:
		cur_path = path_0
		cur_curve = curve_0
	
	# El punto a seguir que está adelantado
	var point_follow : PathFollow3D = cur_path.get_child(0) 
	var target = point_follow.position
	
	# Ponemos en una posision adelantada el punto a seguir
	var car_offset = cur_curve.get_closest_offset(position)
	point_follow.progress = car_offset + pos_offset
	
	var move = Vector3.ZERO
	if is_march:
		move = position.direction_to(target) * engine_power
	
	velocity = move
	
	move_and_slide()
	# Rotacion de carro con quaternions, se iguala la basis(direccion en 3d) del punto a seguir 
	var target_basis = point_follow.transform.basis.orthonormalized()
	transform.basis = transform.basis.slerp(target_basis, delta*2.0)
	
	position.y = max(position.y, floor_limit)
