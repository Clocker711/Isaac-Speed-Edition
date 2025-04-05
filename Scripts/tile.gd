extends Node2D

func _physics_process(delta: float) -> void:
	respwan()
	position.y+=delta*100
func respwan():
	if position.y>= $"../BottomMarker2D".position.y:
		position.y = $"../StartMarker2D".position.y
