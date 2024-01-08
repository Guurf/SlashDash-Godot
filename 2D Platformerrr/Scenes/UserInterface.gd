extends Control
@onready var player = $"../../Player"

@onready var y_velocity = $"Y Velocity"
@onready var x_velocity = $"X Velocity"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	y_velocity.text = str(int(player.velocity.y * 10 * delta)) + " Yv"
	x_velocity.text = str(int(player.velocity.x * 10 * delta)) + " Xv"
