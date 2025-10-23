extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.play("Dance",1.0,false)

func _physics_process(_delta: float) -> void:
	pass
