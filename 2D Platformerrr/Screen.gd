extends Node2D
@onready var screen = $GreenSquare


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	screen.scale.x = lerpf(screen.scale.x, 4, 0.02)
	screen.scale.y = lerpf(screen.scale.y, 3, 0.02)
