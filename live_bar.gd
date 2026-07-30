extends ProgressBar

@export var hp : float = 4
var hp_blocs : int = 4
var unit_hit

func _ready() -> void:
	unit_hit = size.x / hp
	hp_blocs = float(hp - 1)
	var seperator = $VSeparator
	
	for i in hp_blocs-1:
		var inst = seperator.duplicate()
		add_child(inst)
	
	var step_length = unit_hit
	for y in get_children():
		y.position.x += step_length 
		step_length += unit_hit

func hurt(hit : float = unit_hit):
	hp -= hit
	value -= max_value / hp_blocs
	if hp <= 0.0:
		get_tree().call_deferred("reload_current_scene")
