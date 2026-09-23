extends Node

var offset_pos : Vector3
@onready var camera : Camera3D = $Camera3D
@export var ancher_point : Marker3D
var Microbus : CharacterBody3D

func _ready():
	offset_pos = camera.position
	Microbus = get_parent()

func _physics_process(delta):
	#var trans = camera.global_transform.interpolate_with(ancher_point.global_transform, delta* 12.5)
	#camera.global_transform = trans
	
	
	
	pass
