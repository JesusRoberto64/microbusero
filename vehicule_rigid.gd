extends RigidBody3D

var wheel_base = 3.0
var steering_angle = 15
var steer_direction := 0.0

@export var speed = 0.3
var velocity := Vector3.ZERO

var floor_limit = 0.0

func _ready():
	steering_angle = deg_to_rad(steering_angle)
	Engine.max_fps = 60

func _physics_process(delta):
	var turn = Input.get_axis("ui_left", "ui_right")
	steer_direction = turn * steering_angle
	velocity = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = Vector3(-basis.z.x, 0.0, -basis.z.z) * speed
	
	velocity.y = -0.08
	print("VEL", velocity)
	add_constant_central_force(velocity)
	print(linear_velocity)
	position.y = max(position.y, floor_limit)
	pass
