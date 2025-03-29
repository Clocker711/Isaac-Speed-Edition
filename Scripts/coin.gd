extends AnimatedSprite2D
var direction
var speed = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name="coin"
func init(tpos):
	position=tpos

func _process(delta: float) -> void:
	if $Timer.is_stopped():
		move(get_parent().get_node("Player").position,delta)#父节点才能访问Playerdd
		
func move(target,delta):
	direction = (target-position).normalized()
	position += direction*speed*delta
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name =="Player":
		body.Coin_Num +=1
		queue_free()
		
