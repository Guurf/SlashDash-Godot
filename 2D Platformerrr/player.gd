extends CharacterBody2D

@export var movement_data : PlayerMovementData
@export var ghost_node : PackedScene
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var dash_timer = $DashTimer
@onready var ghost_timer = $GhostTimer
@onready var starting_position = global_position

var state = "free"
var dash_dir
var dash_count = 2
var buffer_frames_left = 0
var velocity_previous = Vector2()
var hit_the_ground = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var input_axis = Input.get_axis("left", "right")
	print("X Velocity: ", round(velocity.x))
	if state == "free":
		if velocity.x <= 300 and velocity.x >= -300: ghost_timer.stop()
		apply_gravity(delta)
		handle_jump()
		handle_acceleration(input_axis, delta)
		apply_friction(input_axis, delta)
		apply_air_resistance(input_axis, delta)
		var was_on_floor = is_on_floor()
		move_and_slide()
		var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
		if just_left_ledge:
			coyote_jump_timer.start()
		if Input.is_action_just_pressed("ui_up"):
			movement_data = load("res://IceyMovementData.tres")
		if Input.is_action_just_pressed("dash") and dash_count > 0 and not is_on_floor(): 
			dash_count -= 1
			state = "dash"
			dash_timer.start()
			ghost_timer.wait_time = 0.05
			ghost_timer.start()
			dash_dir = get_local_mouse_position().normalized()
	elif state == "dash":
		handle_dash(dash_dir)
		handle_jump()
		move_and_slide()
	update_animations(input_axis, delta)
	velocity_previous = velocity
#-------------------FUNCTIONS-------------------

func handle_dash(dash_dir):
	if dash_timer.time_left > 0.0 and not is_on_floor():
		velocity = Vector2(600 * dash_dir.x, 600 * dash_dir.y)
		#animated_sprite_2d.scale.y = 0.5 + (abs(velocity.y)/500)
		print(animated_sprite_2d.scale.y)
		#animated_sprite_2d.scale.x = 0.5 + (abs(velocity.x)/500)
	elif dash_timer.time_left <= 0.0:
		velocity = Vector2(100 * dash_dir.x, 100 * dash_dir.y)
		state = "free"
	elif is_on_floor():
		if velocity.x > 400: velocity = Vector2(350,0)
		elif velocity.x < -400: velocity = Vector2(-350,0)
		else: velocity = Vector2(0,0)
		state = "free"

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta
	else: dash_count = 2

func handle_jump():
	var wave_jump = 1.0
	if velocity.x > 200 or velocity.x < -200: wave_jump = 1.8
	else: wave_jump = 1.0
	
	if buffer_frames_left > 0:
		if is_on_floor() or coyote_jump_timer.time_left > 0.0:
			velocity.y = movement_data.jump_velocity
			velocity.x *= wave_jump
			dash_count = 2
			buffer_frames_left = 0
		else:
			buffer_frames_left -= 1
	elif Input.is_action_just_pressed("jump"):
		if is_on_floor() or coyote_jump_timer.time_left > 0.0:
			velocity.y = movement_data.jump_velocity
			velocity.x *= wave_jump
			dash_count = 2
		else:
			buffer_frames_left = 10
	elif Input.is_action_just_released("jump") and velocity.y < movement_data.jump_velocity / 2:
		velocity.y = movement_data.jump_velocity / 2
	
func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance)

func update_animations(input_axis, delta):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	if not is_on_floor():
		if velocity.y < 2: animated_sprite_2d.play("jump")
		else: animated_sprite_2d.play("fall")
		hit_the_ground = false
	if not hit_the_ground and is_on_floor():
		hit_the_ground = true
		animated_sprite_2d.scale.x = remap(abs(velocity_previous.y), 0, abs(1700), 1.2, 2.0)
		animated_sprite_2d.scale.y = remap(abs(velocity_previous.y), 0, abs(1700), 0.7, 0.5)
		
	animated_sprite_2d.scale.x = lerpf(animated_sprite_2d.scale.x, 1, 1 - pow(0.001, delta))
	animated_sprite_2d.scale.y = lerpf(animated_sprite_2d.scale.y, 1, 1 - pow(0.001, delta))

func add_ghost():
	var ghost = ghost_node.instantiate()
	var flip_axis = (Input.get_axis("left", "right")) < 0
	var ghost_col = Color(0, 2.5, 0, 0.3)
	if state == "free": 
		ghost_col = Color(2, 7, 2, 0.1)
		ghost_timer.wait_time = 0.1
	ghost.set_property(position, animated_sprite_2d.scale, flip_axis, ghost_col)
	get_tree().current_scene.add_child(ghost)

func _on_ghost_timer_timeout():
	add_ghost()


func _on_hazard_detector_area_entered(area):
	position = starting_position
	state = "free"
	velocity = Vector2(0, 0)
