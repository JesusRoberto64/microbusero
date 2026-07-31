extends Node3D

@onready var microbus = $Micro_characer
@onready var route : Path3D = $Ruta
@onready var path_forward : PathFollow3D = $Ruta/PathFroward
@onready var path_backward : PathFollow3D = $Ruta/PathBackward

@onready var live_bar : ProgressBar = $CanvasLayer/LiveBar
var timer = 0.0
var timer_limit = 1.5

var curve: Curve3D

signal recover_micro

func _ready():
	curve = route.curve
	microbus.hited.connect(hurt_micro)
	recover_micro.connect(microbus.recover)

func _process(delta):
	if timer > 0.0:
		timer -= delta
		if timer < 0.0: 
			timer = 0.0
			recover_micro.emit()
	elif timer == 0.0:
		var route_point = curve.get_closest_point(microbus.position)
		
		var diff_points : Vector3 = route_point - microbus.position
		var distance_to_route = abs(diff_points.length())
		
		if distance_to_route > 5.0:
			live_bar.hurt()
			microbus.hurt()
			timer = timer_limit
	
	# Movimiento de ruta
	var micro_offset = curve.get_closest_offset(microbus.position)
	var vision_offset = 5.0
	var vision_step = 20.0
	
	if micro_offset >= path_forward.progress + vision_offset:
		path_forward.progress = micro_offset + vision_step
		path_backward.progress = path_forward.progress - (vision_offset + vision_step)
	elif micro_offset <= path_backward.progress - vision_offset:
		path_backward.progress = micro_offset - vision_step
		path_forward.progress = path_backward.progress + (vision_offset + vision_step)

func hurt_micro():
	microbus.hurt()
	live_bar.hurt()
	timer = timer_limit
