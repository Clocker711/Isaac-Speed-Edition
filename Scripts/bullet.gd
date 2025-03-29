extends Node2D

var speed
var inertia


func initialize(pos,Tspeed,Pspeed) -> void:#传入位置，速度
	speed = Tspeed
	position =pos
	inertia = Pspeed
func _ready() -> void:
	add_to_group("bullet")
	
func _physics_process(delta: float) -> void:
	position.y -= speed*delta
	inertia = Analog_inertia(inertia,0.19)#模拟衰减速度
	position.x += inertia*delta

func Analog_inertia(v,Factor):
	v=v*(1-Factor)
	if abs(v)<1:
		return 0
	else:
		return v
	
func blast():#击中后的爆裂动画
	$AnimatedSprite2D.play("blast")
	speed=0
	inertia=0
	$AnimatedSprite2D.animation_finished.connect(queue_free)
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
