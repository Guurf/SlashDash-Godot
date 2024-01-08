extends Node2D
@onready var screen = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	screen.scale.x = lerpf(screen.scale.x, 120, 0.02)
	screen.scale.y = lerpf(screen.scale.y, 85, 0.02)
	screen.position.x = lerpf(screen.position.x, -244, 0.02)
	screen.position.y = lerpf(screen.position.y, 91, 0.02)
