extends Node
#利用单例永远存在的性质来访问对象

@onready var player = get_node("/root/Main/Player")

func queue_aftersound(body):#播放完音效后死亡
	body.death_state = true
	body.visible = false
	await get_tree().create_timer(body.get_node("AudioStreamPlayer2D").stream.get_length()).timeout
	if is_instance_valid(body):
		body.queue_free()

func Shine(timer,i):#计时器时间输入，次数
	#返回01序列
	var sec = timer.wait_time/i
	return (pow(-1,int(timer.time_left/sec))+1)/2
	
	#玩家全局数据
	
