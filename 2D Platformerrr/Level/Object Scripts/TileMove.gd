extends TileMap
@export var xMove : int = 0.0
@export var yMove : int = 0.0
@export var moveSpeed : float = 5.0

var xStart = position.x
var yStart = position.y

var activated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activated == true:
		position.x = lerpf(position.x, xStart+xMove, moveSpeed/100)
		position.y = lerpf(position.y, yStart+yMove, moveSpeed/100)
