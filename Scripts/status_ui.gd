extends Node2D

var heart = ResourceLoader.load("res://Scene/heart.tscn")

func showHp(hp):
	var Hearts =  $HP.get_children()
	if len(Hearts)< hp:
		var heart_instant=heart.instantiate()
		heart_instant.init(len(Hearts))
		$HP.add_child(heart_instant)
	if len(Hearts)> hp:
		Hearts[-1].queue_free()
func CoinNum():
	$Coins/Label.text = str(%Player.Coin_Num)
	
func _process(delta: float) -> void:
	showHp(%Player.Hp)
	CoinNum()
	
	
