extends TextureFrame

func _on_button_pressed():
	get_tree().change_scene("res://scenes/main/game.tscn")

func _ready():
	preload("res://scenes/main/game.tscn")
	get_node("press").connect("pressed",self,"_on_button_pressed")