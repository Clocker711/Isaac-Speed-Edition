extends AnimatedSprite2D
var direction
var speed = 500
var death_state = false

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
	if body.name =="Player" and not death_state:
		body.Coin_Num +=1
		$AudioStreamPlayer2D.play()
		death_state = true
		Global.queue_aftersound(self)
		
