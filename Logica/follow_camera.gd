extends Camera3D

@export var ancher_point : Marker3D
@export var limit_cam : Marker3D
var counter = 0.0
var number = 0

func _ready():
	ancher_point.position = position
	ancher_point.rotation = rotation
	top_level = true

func _physics_process(delta):
	#transform.origin = transform.origin.lerp(ancher_point.global_transform.origin, delta * 15.5) 
	## problema con bug
	#var norm_basis = transform.basis.orthonormalized()
	#print(transform.basis)
	#transform.basis = norm_basis.slerp(ancher_point.global_transform.basis, delta * 10.0) 
	pass
