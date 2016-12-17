extends Node2D

var direction 				= Vector2(1.0, 0.0)
var ball_speed				= initial_ball_speed

const initial_ball_speed 	= 50
const pad_speed				= 130

#----------
onready var pad_size 		= get_node("left").get_texture().get_size()
onready var ball_pos 		= get_node("ball").get_pos()
onready var left_rect 		= Rect2(get_node("left").get_pos() - pad_size*0.5, pad_size)
onready var right_rect 		= Rect2(get_node("right").get_pos() - pad_size*0.5, pad_size)
onready var left_pos		= get_node("left").get_pos()
onready var right_pos		= get_node("right").get_pos()
#----------

func _ready():
	#---------
	var ball	= get_node("ball");
	var leftPad	= 5
	#---------
	set_process(true)
	pass

func _process(delta):
	flip()
	gameover()
	move_pad(delta)
	
	print (ball_pos)
	#ball_pos += direction * ball_speed * delta
	ball_motion(delta)


func flip():
	if ((ball_pos.y > 31 and direction.y < 31) or (ball_pos.y > -31 and direction.y > -31)):
		direction.y = -direction.y  #Changing direction when hiting the top or floor

	if ((left_rect.has_point(ball_pos) and direction.x < 31) or (right_rect.has_point(ball_pos) and direction.x > -31)):
		direction.x		= -direction.x
		direction.y		= randf()*2.0 - 1        #Flip when hiting a pad and Increasing speed when fliping
		direction		= direction.normalized()
		ball_speed     *= 1.05

func gameover():
	if (ball_pos.x < -31 or ball_pos.x > 31):
		ball_pos.x 	= 0
		ball_pos.y	= 0 
		ball_speed 	= initial_ball_speed		# Checking for Game Over
		direction	= Vector2(1, 0.0)

	get_node("ball").set_pos(ball_pos)

func move_pad(delta):
	
	if (left_pos.y > -29.90 and Input.is_action_pressed("left_move_up")): 
		left_pos.y 	+= -pad_speed * delta
	if (left_pos.y < 22 and Input.is_action_pressed("left_move_down")): # Move left pad
		left_pos.y 	+= pad_speed * delta
	
	get_node("left").set_pos(left_pos)

	if (right_pos.y > -27 and Input.is_action_pressed("right_move_up")):
		right_pos.y += -pad_speed * delta
	if (right_pos.y < 25 and Input.is_action_pressed("right_move_down")): # Move right pad
		right_pos.y += pad_speed * delta

	get_node("right").set_pos(right_pos)

func ball_motion(delta):
	ball_pos += ball_speed * direction * delta