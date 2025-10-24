extends Control

@onready var login: Button = $login

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if login.button_pressed:
		get_tree().change_scene_to_file("res://scene/Main.tscn")
