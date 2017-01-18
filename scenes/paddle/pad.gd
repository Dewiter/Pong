tool 
extends KinematicBody2D

export(int, 1, 2) var player = 1


export(Color, RGB) var playerColor = Color(1,1,1) setget setPlayerColor 

var velocity = 200
var upDirection = Vector2(0,-3)
var downDirection = Vector2(0,3)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_action_pressed("player"+str(player)+"_down"):
		move(downDirection*velocity*delta)
	if Input.is_action_pressed("player"+str(player)+"_up"):
		move(upDirection*velocity*delta)

func setPlayerColor(_newValue):
	playerColor = _newValue
	if has_node("body"): 
		get_node("body").set_color(playerColor)