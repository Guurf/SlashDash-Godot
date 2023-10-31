extends AnimatableBody2D

@export var path2d:Path2D
@export var pathFollow:PathFollow2D
@export var speed:float = 50.0
@export_range(0.0, 1.0) var time:float = 0.0
@export var curve:Curve

var speed_scale:float
var direction:int = 1

func _ready()->void:
	speed_scale = 1.0 / (path2d.curve.get_baked_length() / speed)
