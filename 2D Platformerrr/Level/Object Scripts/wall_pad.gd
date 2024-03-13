extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_right_bounce_area_entered(area):
	var player = area.get_parent()
	if player.velocity.y < -350: player.velocity.y = -350
	if player.state != "death": player.state = "free"
	player.dash_count = 1
	var xvel = player.velocity.x
	player.velocity.x = 400

func _on_left_bounce_area_entered(area):
	var player = area.get_parent()
	if player.velocity.y < -350: player.velocity.y = -350
	if player.state != "death": player.state = "free"
	player.dash_count = 1
	player.velocity.x = -400
