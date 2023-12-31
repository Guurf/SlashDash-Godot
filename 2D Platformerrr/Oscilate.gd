extends AnimatableBody2D

@export var distance: Vector2
@export var phase_time: float = 6.0
@export var return_time: float = 10.0
@export_range(0.0, 1.0) var phase_offset:float
@export var debug:bool = true

var pivot:Vector2
var pos:Vector2
@export_range(-1.0, 1.0) var time:float
var current_time:float

func _ready()->void:
	pos = global_position
	current_time = phase_time
	pos.y = global_position.y + distance.y
	pivot = pos
	set_process(debug)
	
func get_pos(t:float)->Vector2:
	var x:float = pivot.x + cos(TAU * (t + phase_offset)) * distance.x
	var y:float = pivot.y + sin(TAU * t) * distance.y
	return Vector2(x, y)

func _physics_process(delta:float)->void:
	time = fmod(time + delta/current_time, 1.0)
	if (global_position.y - pivot.y) >= (distance.y - 2) and current_time != return_time: current_time = return_time
	elif (global_position.y - pivot.y) <= (-distance.y + 2) and current_time != phase_time: current_time = phase_time
	global_position = get_pos(time)
	#print(current_time)
	
func _process(delta):
	queue_redraw()
	
func _draw() -> void:
	if !debug:
		return
	var resolution:int = 20
	var increments:float = 1.0/resolution
	for i in resolution:
		var a: = get_pos(increments * i) - global_position
		var b: = get_pos(increments * (i+1)) - global_position
		draw_line(a, b, Color.WHITE, -1)


