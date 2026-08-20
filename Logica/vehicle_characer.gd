extends CharacterBody3D

var engine_power = 20.0
var max_speed = 10.0
var stearig_angle = 25.0
var drag = 1.0
var tire_grip = 8.0
var gravity = 9.8

var floor_limit = 0.5

@onready var anim = $AnimationPlayer
signal hited
var is_hurt = false

func _ready():
	stearig_angle = deg_to_rad(stearig_angle)

func _physics_process(delta):
	velocity.y -= gravity
	
	var march = Input.get_axis("ui_down", "ui_up") 
	var turn = Input.get_axis("ui_left", "ui_right")
	
	var forward_dir = -transform.basis.z
	var side_dir = transform.basis.x
	
	var accel = Vector3.ZERO
	if march != 0.0:
		accel = forward_dir * engine_power * march
	
	var forward_vel = forward_dir * velocity.dot(forward_dir)
	var lateral_vel = side_dir * velocity.dot(side_dir)
	
	# Friccion y derrape
	forward_vel -= forward_vel * drag * delta
	lateral_vel = lateral_vel.lerp(Vector3.ZERO, tire_grip * delta)
	
	velocity = forward_vel + lateral_vel + (accel * delta)
	
	# Rotacion
	var speed_factor = forward_vel.dot(forward_dir)
	if abs(speed_factor) > 0.1:
		var steer_rad = stearig_angle * -turn
		rotate_y(steer_rad * (speed_factor / max_speed)  * delta * 3.0)
		
	move_and_slide()
	
	if is_on_wall() and not is_hurt:
		hited.emit()
		is_hurt = true
	
	position.y = max(position.y, floor_limit)

func recover():
	anim.play("RESET")
	is_hurt = false

func hurt():
	anim.play("hurt")
