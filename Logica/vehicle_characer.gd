extends CharacterBody3D

var engine_power = 20.0
var max_speed = 10.0
var stearig_angle = 20.0
var drag = 1.0
var tire_grip = 8.0
var gravity = 9.8

var floor_limit = 0.5

@onready var anim = $AnimationPlayer
signal hited
var is_hurt = false

var turn_curve = 0.0

var timer = 1.0
var timer_limit = 1.0 

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
	
	# Rotacion =======
	
	
	var speed_factor = forward_vel.dot(forward_dir)
	if abs(speed_factor) > 0.1:
		var steer_rad = stearig_angle * -turn
		
		# Delay de giro, emula el tiempo que se tarda en girar y da precicion.
		if turn != 0.0:
			turn_curve += delta * 2.0
			turn_curve = min(turn_curve, 1.0)
		else:
			turn_curve = lerp(turn_curve, 0.0, delta)
		steer_rad *= ease(turn_curve, 3.0) #turn_curve
		
		rotate_y(steer_rad * (speed_factor / max_speed)  * delta * 3.0)
		
	move_and_slide()
	
	if is_on_wall() and not is_hurt:
		hurt()
	if is_hurt:
		timer -= delta
		if timer <= 0.0:
			recover()
	
	position.y = max(position.y, floor_limit)

func recover():
	anim.play("RESET")
	timer = timer_limit
	is_hurt = false

func hurt():
	#hited.emit()
	anim.play("hurt")
	is_hurt = true
