extends Camera2D
var zoom_in = false
@onready var player = $".."
@onready var animated_sprite_2d = $"../AnimatedSprite2D"

var pause_scene = preload("res://UI/pause_scene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		zoom_in = true
	
	if zoom_in == true:
		zoom.x = lerp(zoom.x, 15.0, 0.01)
		zoom.y = lerp(zoom.y, 15.0, 0.01)

	if zoom.x >= 10.0:
		get_tree().change_scene_to_packed(pause_scene)
