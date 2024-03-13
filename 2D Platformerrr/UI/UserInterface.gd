extends Control
@onready var player = $"../../Player"

@onready var y_velocity = $"Y Velocity"
@onready var x_velocity = $"X Velocity"
@onready var level_time = $"Level Time"
@onready var fps = $FPS

var time = 0.0
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		paused = !paused
	if !paused: time += 1 * delta
	level_time.text = str(round_place(time,2))
	y_velocity.text = str(int(player.velocity.y * 10 * delta)) + " Yv"
	x_velocity.text = str(int(player.velocity.x * 10 * delta)) + " Xv"
	fps.text = str(int(Engine.get_frames_per_second())) + " fps"

func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
