extends Node2D


var launch_direction = 0.0
@export var launch_velocity = 1000
@onready var sprite_2d_2 = $Sprite2D2
@onready var sprite_2d = $Sprite2D
@onready var default_pos = get_position()
@onready var default_scale = scale

var amplitude = 4.0
var time = 0
var frequency = 2.0

func _ready()->void:
	launch_direction = rotation

func _process(delta) -> void:
	if scale != default_scale: 
		scale = Vector2(lerpf(scale.x, default_scale.x, 0.1), lerpf(scale.y, default_scale.y, 0.05))
	time += delta * frequency
	set_position(default_pos + Vector2(0, sin(time) * amplitude))
