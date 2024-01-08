extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale.x = lerpf(scale.x, 40.0, 0.05)
	scale.y = lerpf(scale.y, 22.5, 0.05)
	position.x = lerpf(position.x, 0, 0.05)
	position.y = lerpf(position.y, 0, 0.05)
