extends Camera3D

@export var ancher_point : Marker3D
@export var limit_cam : Marker3D

func _ready():
	ancher_point.position = position
	ancher_point.rotation = rotation
	top_level = true

func _physics_process(delta):
	transform.origin = transform.origin.lerp(ancher_point.global_transform.origin, delta * 15.5) 
	transform.basis = transform.basis.slerp(ancher_point.global_transform.basis, delta * 15.5) 
	#transform.interpolate_with(ancher_point.global_transform, 12.5)
	
	pass
