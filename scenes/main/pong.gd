extends Node2D

var screen_size				= get_viewport_rect().size
var direction 				= Vector2(1.0, 0.0)
const initial_ball_speed 	= 50
var ball_speed				= initial_ball_speed

const pad_speed				= 130

#----------
onready var ball			= get_node("ball")
onready var left			= get_node("left")
onready var right			= get_node("right")

onready var left_pos		= left.get_pos()
onready var right_pos		= right.get_pos()
onready var pad_size 		= left.get_texture().get_size()
onready var ball_pos 		= ball.get_pos()
onready var right_goal		= get_node("right_goal").get_pos()
onready var left_goal		= get_node("left_goal").get_pos()

onready var left_rect 		= Rect2(left_pos - pad_size*0.5, pad_size)
onready var right_rect 		= Rect2(right_pos - pad_size*0.5, pad_size)
#----------

func _ready():
	set_process(true)

func _process(delta):
	ball_motion(delta)
	move_pad(delta)
	flip()
	print(ball_speed)

func ball_motion(delta):
	ball_pos += ball_speed * direction * delta
	ball.set_pos(ball_pos)

func flip(): 
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)): #Changing direction when hiting the top or floor
		direction.y = -direction.y 

	if ((left_rect.has_point(ball_pos) and direction.x <= 0) or (right_rect.has_point(ball_pos) and direction.x >= 0)): #Flip when hiting a pad and Increasing speed when fliping
		direction.x		= -direction.x
		direction.y		= -direction.y
		direction		= direction.normalized()
		ball_speed     *= 1.1

	if(ball_pos.x < left_goal.x or ball_pos.x > right_goal.x):
		ball_pos.x 	= 0
		ball_pos.y 	= 0
		ball_speed 	= initial_ball_speed
		direction	= Vector2(1, 0.0)
		                
func move_pad(delta):
	# Move left pad
	if (left_pos.y >= -29.75 and Input.is_action_pressed("left_move_up")): 
		left_pos.y 	+= -pad_speed * delta
	if (left_pos.y <= 20 and Input.is_action_pressed("left_move_down")): 
		left_pos.y 	+= pad_speed * delta

	left.set_pos(left_pos)
	# Move right pad
	if (right_pos.y >= -27 and Input.is_action_pressed("right_move_up")):
		right_pos.y += -pad_speed * delta
	if (right_pos.y <= 25 and Input.is_action_pressed("right_move_down")): 
		right_pos .y += pad_speed * delta

	right.set_pos(right_pos)