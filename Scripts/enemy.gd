extends CharacterBody2D


func init(vector,pos):
	velocity= vector
	position= pos
	
func _ready() -> void:
	add_to_group("monster")
func _physics_process(delta: float) -> void:
	move_and_slide()
	

var Coin_Scene = preload("res://Scene/Coin.tscn")

func Ramdom(p):
	if randf()>p:
		return 0
	else:
		return 1
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_parent().is_in_group("bullet"):
		body.get_parent().blast()
		if Ramdom(0.6):#金币掉落概率
			var C_instant = Coin_Scene.instantiate()
			C_instant.init(position)
			get_parent().add_child(C_instant)
		queue_free()
		  

	
