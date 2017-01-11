extends KinematicBody2D

var direction = Vector2(3, 0)
var Velocity = 300
const initial_ball_pos = Vector2(0, 0)
onready var ball = get_node("ball")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if(is_colliding() == 1):
		
		if(get_collider().is_in_group("pad")):
			var _diff = get_collider().get_pos().y-get_collision_pos().y
			direction = Vector2(direction.x* -1,_diff/70*-1)
		
		if(get_collider().is_in_group("wall")):
			direction = Vector2(direction.y * -1 , direction.x)
		
		if(get_collider().is_in_group("goal")):
			direction.x = -direction.x
			direction.y -= direction.y
			if (ball.x == 0):
				direction = Vector2(0, 5)
				if(ball.x == 0 and ball.y == 0):
					direction = Vector(0, 0)

		move(direction * Velocity * delta)
	else:
		move(direction)