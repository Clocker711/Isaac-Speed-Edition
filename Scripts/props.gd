extends StaticBody2D
var velocity=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.name = "props"

func init(pos,speed):
	position = pos
	velocity = speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y+= velocity

func effect():
	Global.player.add_bullet()
	#queue_free()
