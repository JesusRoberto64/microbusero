extends CharacterBody3D

var gravity = 5.0
var speed = 8.0
var engine_power = 500.0
var accel := Vector3.ZERO

var wheel_base = 3.0
var steering_angle = 25
var steer_direction 
var friction = -0.02
var drag = -0.01

var floor_limit = 0.5

func _ready():
	steering_angle = deg_to_rad(steering_angle)

func _physics_process(delta):
	# Inputs
	var turn = Input.get_axis("ui_left", "ui_right")
	steer_direction = -turn * steering_angle
	var dir = Vector3(basis.z.x, 0.0, basis.z.z)
	
	#velocity = Vector3.ZERO
	#if Input.is_action_pressed("ui_up"):
		#velocity = dir * speed
	
	accel = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		accel = dir * engine_power * delta
	
	# Aplicar fricción
	if accel == Vector3.ZERO and accel.length() < 0.01:
		velocity = Vector3.ZERO
	
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	accel += drag_force + friction_force
	
	print(accel.length(), " accel")
	# Calcular giro de vehiculo
	var rear_wheel = dir
	#var front_wheel = dir + velocity.rotated(Vector3.UP, steer_direction)
	var front_wheel = dir + accel.rotated(Vector3.UP, steer_direction)
	var new_haeding = rear_wheel.direction_to(front_wheel)
	#velocity = new_haeding * velocity.length()
	velocity = new_haeding * accel.length()
	velocity += accel
	#print(velocity.length())
	
	velocity.y -= gravity
	
	move_and_slide()
	
	rotate_y(-turn * velocity.length() * 0.25 * delta)
	
	position.y = max(position.y, floor_limit)
	pass
