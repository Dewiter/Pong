extends KinematicBody2D

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (Input.is_action_pressed("left_move_up")):
		move(Vector2(0, -5.0))
	if (Input.is_action_pressed("left_move_down")):
		move(Vector2(0, 5.0))