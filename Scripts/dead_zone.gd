extends Area2D

func _process(delta: float) -> void:
	pass
	


func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
