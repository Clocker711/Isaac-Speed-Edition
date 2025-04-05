extends CharacterBody2D
var Hp = 20
var death_state = false
func init(vector,pos):
	velocity= vector
	position= pos
	
func _ready() -> void:
	add_to_group("monster")

func _physics_process(delta: float) -> void:
	if not death_state:
		move(delta)
	dead()

func move(delta):
	#按照path2d循环的简易路径
	if $Path2D/PathFollow2D.progress_ratio ==1:
		$Path2D/PathFollow2D.progress_ratio=0
	var last_pos = $Path2D/PathFollow2D.position
	$Path2D/PathFollow2D.progress += velocity[1]*delta
	var next_pos = $Path2D/PathFollow2D.position
	var direction = next_pos - last_pos
	position += direction

var Coin_Scene = preload("res://Scene/Coin.tscn")

func Ramdom(p):#概率函数
	if randf()>p:
		return 0
	else:
		return 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not death_state:
		if body.get_parent().is_in_group("bullet"):
			Hp-= Global.player.ATK * body.get_parent().bullet_Atk
			body.get_parent().blast()
				  
func dead():
	if Hp<=0:
		if not death_state:
			if Ramdom(0.6):#金币掉落概率
				var C_instant = Coin_Scene.instantiate()
				C_instant.init(position)
				get_parent().add_child(C_instant)
			$AudioStreamPlayer2D.play()
		Global.queue_aftersound(self)
func queue_aftersound(Music):
	death_state = true
	visible = false
	await  get_tree().create_timer(Music.stream.get_length()).timeout
	queue_free()
