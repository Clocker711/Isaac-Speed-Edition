extends Node2D

var speed
var inertia
var distance_moved = 0
var startdot:Vector2
var distance = 200 
var bullet_Atk = 10
func initialize(pos,v,Pspeed,dis) -> void:#传入位置，速度
	speed = v
	position =pos
	inertia = Pspeed
	startdot = pos
	distance = dis
func _ready() -> void:
	add_to_group("bullet")
	
func _physics_process(delta: float) -> void:
	move(delta)

func move(delta):
	position.x += speed[0]*delta
	position.y += speed[1]*delta
	inertia = Analog_inertia(inertia,0.19)#模拟衰减速度
	position.x += inertia*delta
	if Vector2(position-startdot).length() >= distance:
		blast()
func Analog_inertia(v,Factor):
	v=v*(1-Factor)
	if abs(v)<1:
		return 0
	else:
		return v
	
func blast():#击中后的爆裂动画
	$AnimatedSprite2D.play("blast")
	speed=Vector2()
	inertia=0
	$AnimatedSprite2D.animation_finished.connect(queue_free)
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
