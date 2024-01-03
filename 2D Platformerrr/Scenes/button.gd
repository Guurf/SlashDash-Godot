extends Node2D
var activated: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	activated = true
	for child in get_children():
		if child is TileMap:
			child.activated = true
