
extends Area2D

export(int, 1, 2) var player = 1

func _ready():
	connect("body_enter",self,"_goal")


func _goal(_body):
	if _body.is_in_group("ball"):
		get_tree().call_group(0, "game", "goal",player)
		_body.free()
	