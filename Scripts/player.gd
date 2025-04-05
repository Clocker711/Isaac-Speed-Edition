extends CharacterBody2D
var bullet = ResourceLoader.load("res://Scene/bullet.tscn")
#角色属性变量
@export var SPEED = 300.0
@export var Hp=3
#攻击属性
@export var bullet_num = 1
@export var dispersion_factor = 1
@export var bullet_speed = 300
@export var bullet_distance = 200
@export var shot_speed = 1
@export var luck = 0
@export var ATK = 1
#状态
var Igore_Damage = false
var death = false
#数据类
var Coin_Num = 0

		
func _ready() -> void:

	$CDTimer.timeout.connect(Attack)
	$NoDamageTimer.timeout.connect(func(): Igore_Damage=false)
	
	

func _physics_process(delta: float) -> void:
	if not death:
		state_update()
		move()
		apperance()

func move():
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		$Head.position=Vector2(1,-11)
		$Head.play("move")
		$Body.play("walk")
		#图形反转
		if direction<0:
			$Body.flip_h = true
			$Head.flip_h = true	
		if direction>0:
			$Body.flip_h =false
			$Head.flip_h = false
		velocity.x = direction * SPEED
	else:
		$Head.position=Vector2(0,-10.0)
		$Head.play("idle")
		$Body.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)	
	move_and_slide()

func Attack():#攻击
	
	for i in range(bullet_num):
		var bullet_instance= bullet.instantiate()
		var v_x = 16.0*dispersion_factor*(i-center(bullet_num)+1) #子弹x方向速度分量 a(x-中点)
		var v_y = -1.0*sqrt(bullet_speed**2- v_x**2)
		bullet_instance.initialize(position,Vector2(v_x,v_y),velocity.x,bullet_distance)
		get_parent().add_child(bullet_instance)	
func add_bullet():
	var x = abs(16.0*dispersion_factor*(0-center(bullet_num)+1))
	if bullet_speed - x>=0:
		bullet_num += 1
	print()
func center(n):
	if n%2 == 0:
		return n/2+0.5
	else:
		return n/2+1

func apperance():
	if Igore_Damage:
		modulate=Color(1,0,0)
		if Global.Shine($NoDamageTimer,5):
			modulate=Color(1,1,1)
	else:
		modulate=Color(1,1,1)
func dead():
	if not Igore_Damage:
		Hp-=1
	#受到攻击效果
		$HitSound.play()
	if Hp<=0:
		#死亡
		$Body.play("dead")
		$Head.visible=false
		death =true 
		Engine.time_scale = 0.5
		$DeadSound.play()
		await get_tree().create_timer(1).timeout
		
		Engine.time_scale = 1
		get_tree().reload_current_scene()
	else:
		Igore_Damage = true
		$NoDamageTimer.start()

func state_update():
	$CDTimer.wait_time = shot_speed		

#检测碰撞函数
func _on_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("monster"):
		dead()
	if body.is_in_group("props"):
		body.effect()
		
