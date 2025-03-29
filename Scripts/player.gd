extends CharacterBody2D

var SPEED = 300.0

var bullet = ResourceLoader.load("res://Scene/bullet.tscn")
#角色属性变量
var Hp=3
var Igore_Damage = false
var death = false
var Coin_Num = 0
		
func _ready() -> void:
	$CDTimer.timeout.connect(Attack)
	$NoDamageTimer.timeout.connect(func(): Igore_Damage=false)
	
	

func _physics_process(delta: float) -> void:
	if not death:
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
func Attack():
		var bullet_instance= bullet.instantiate()
		bullet_instance.initialize(position,300,velocity.x)
		get_parent().add_child(bullet_instance)	


func apperance():
	if Igore_Damage:
		modulate=Color(1,0,0)
		if GlobalFun.Shine($NoDamageTimer,5):
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
		


func _on_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("monster"):
		dead()
		
