extends Node

var offset_pos : Vector3
@onready var camera : Camera3D = $Camera3D
@export var ancher_point : Marker3D
var Microbus : CharacterBody3D

func _ready():
	ancher_point.transform = camera.transform
	offset_pos = camera.position
	Microbus = get_parent()

func _physics_process(delta):
	var norm = camera.global_transform.orthonormalized()
	var trans = norm.interpolate_with(ancher_point.global_transform, delta* 8.5)
	camera.global_transform = trans
	
	#camera.transform.origin = camera.transform.origin.lerp(ancher_point.global_transform.origin, delta * 12.5) 
	#var norm = camera.transform.basis.orthonormalized()
	#camera.transform.basis = norm.slerp(ancher_point.global_transform.basis.orthonormalized(), delta * 10.5) 
	pass
	
