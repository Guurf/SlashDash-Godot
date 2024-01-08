extends Node2D
@onready var player = $".."
@onready var arrow = $"."
@onready var slash_mesh = $SlashDetector/MeshInstance2D
@onready var slash_detector = $SlashDetector
@onready var slash_timer = $Slash_Timer
var slash_rot = 0.0

func _process(delta: float) -> void:
	scale = Vector2(0.5, 0.5)
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	if (player.state == "free" or player.state == "crouch") and player.dash_count > 0 and arrow.animation != "default": 
		arrow.play("default")
	elif player.state == "free" and player.dash_count <= 0: 
		arrow.play("dashing")
	elif player.state == "dash": 
		arrow.play("dashing")
	#elif player.state == "crouch" and not player.is_on_floor():
	#	arrow.modulate = Color(1, 1, 1, 0.3)
	#else: arrow.modulate = Color(1, 1, 1, 1)
	if Input.is_action_just_pressed("ui_down"): arrow.visible = not arrow.visible
	
	
	if Input.is_action_just_pressed("slash") and slash_timer.time_left <= 0:
		slash_timer.start()
	
	
	if slash_timer.time_left > 0:
		slash_detector.monitoring = true
		slash_mesh.visible = true
	else:
		slash_detector.monitoring = false
		slash_mesh.visible = false
	
	if rotation_degrees >= 360.0: rotation_degrees = 0.0
	if rotation_degrees <= -360.0: rotation_degrees = 0.0


func _on_slash_detector_area_entered(area):
	#print(area.global_rotation_degrees)
	if player.global_position.y < area.global_position.y-10:
		player.dash_count = 1
		if player.state != "death": player.state = "free"
		player.velocity.y = -300
