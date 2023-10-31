extends Node2D

@export var radius = 30
@onready var arrow = $Arrow
@onready var player = $".."

func _process(_delta):
	var mouse_pos = get_local_mouse_position()
	arrow.look_at(get_global_mouse_position())
	var player_pos = transform.origin 
	var mouse_dir = (mouse_pos-player_pos).normalized()
	if player.state == "dash": radius = lerpf(radius, 50, 0.1)
	else: radius = 30
	arrow.transform.origin = player_pos + (mouse_dir * radius)
