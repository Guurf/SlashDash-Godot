extends Node2D
@onready var player = $".."
@onready var arrow = $"."

func _process(delta: float) -> void:
	scale = Vector2(0.5, 0.5)
	var mouse_pos = get_global_mouse_position()
	if player.state == "free"  and player.dash_count > 0 and arrow.animation != "default": 
		arrow.play("default")
	elif player.state == "free" and player.dash_count <= 0: 
		arrow.play("dashing")
	elif player.state == "dash": 
		arrow.play("dashing")
	look_at(mouse_pos)
