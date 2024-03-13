extends CharacterBody2D

@export_range(0, 360) var direction = 0
@export var speed = 100
@export var lifetime = 5
@export var infinite : bool

var state = "free"
var slashed = false;

@onready var timer = $Timer
@onready var hazard_area = $HazardArea
@onready var trail_particles = $"Trail Particles"
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	timer.stop()
	if (!infinite):
		timer.wait_time = lifetime
		timer.start()

func _physics_process(delta):
	if is_on_wall() || slashed || is_on_ceiling() || is_on_floor() : 
		if state != "break" : scale *= 2
		state = "break"
	
	if state == "free":
		_move()
	elif state == "break":
		_break()

func _move():
	velocity = Vector2(speed, 0).rotated(deg_to_rad(direction))
	move_and_slide()
	
func _break():
	animated_sprite_2d.play("break")
	trail_particles.emitting = false
	hazard_area.monitorable = false
	scale /= 1.2;
	if scale.x <= 0.1 : queue_free()

func _on_timer_timeout():
	scale *= 2;
	state = "break"
