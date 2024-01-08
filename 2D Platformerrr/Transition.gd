extends Control
@onready var panel = $Panel
var stage = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	panel.position = Vector2(640,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stage == 1:
		panel.position.x = lerp(panel.position.x, -10.0, 0.05)
	
	if stage == 2:
		panel.position.x = lerp(panel.position.x, -645.0, 0.05)
	
	if panel.position.x < -640.0: 
		queue_free()
	elif panel.position.x < 0.0: 
		#get_tree().reload_current_scene()
		stage = 2
	
