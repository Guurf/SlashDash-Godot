extends Node2D
@onready var player = $".."
@onready var arrow = $"."

func _process(delta: float) -> void:
	scale = Vector2(0.5, 0.5)
	var mouse_pos = get_global_mouse_position()
	if (player.state == "free" or player.state == "crouch") and player.dash_count > 0 and arrow.animation != "default": 
		arrow.play("default")
	elif player.state == "free" and player.dash_count <= 0: 
		arrow.play("dashing")
	elif player.state == "dash": 
		arrow.play("dashing")
	#elif player.state == "crouch" and not player.is_on_floor():
	#	arrow.modulate = Color(1, 1, 1, 0.3)
	#else: arrow.modulate = Color(1, 1, 1, 1)
	if Input.is_action_just_pressed("ui_down"): arrow.visible = not arrow.visible
	look_at(mouse_pos)
