extends ProgressBar

@export var hp : float = 100.0
@export var hp_blocs : int = 4
var unit_hit : float

func _ready() -> void:
	value = hp
	unit_hit = max_value / hp_blocs
	
	var seperator = $VSeparator
	for i in hp_blocs-2:
		var inst = seperator.duplicate()
		add_child(inst)
	
	var step_length = size.x / hp_blocs
	for y in get_children():
		y.position.x += step_length 
		step_length += size.x / hp_blocs

func hurt(hit : float = unit_hit):
	hp -= hit
	value = hp
	if hp <= 0.0:
		get_tree().call_deferred("reload_current_scene")
