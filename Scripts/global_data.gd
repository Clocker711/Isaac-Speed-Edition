extends Node

func Shine(timer,i):#计时器时间输入，次数
	#返回01序列
	var sec = timer.wait_time/i
	return (pow(-1,int(timer.time_left/sec))+1)/2
