extends TextureFrame

func _on_button_pressed():
	get_tree().change_scene("res://scenes/main/pong.tscn")

func _ready():
	var game = preload("res://scenes/main/pong.tscn")
	get_node("press").connect("pressed",self,"_on_button_pressed")