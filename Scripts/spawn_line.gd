extends PathFollow2D

var monster_scene = ResourceLoader.load("res://Scene/enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../SpwanTimer".timeout.connect(spwan)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spwan():
	var monster_instate = monster_scene.instantiate()
	progress_ratio = randf()
	monster_instate.init(Vector2(0,100),position)
	$"../..".add_child(monster_instate)
