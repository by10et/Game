extends Control

@onready var login: Button = $login


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if login.button_pressed:
		get_tree().change_scene_to_file("res://scene/Main.tscn")
		
