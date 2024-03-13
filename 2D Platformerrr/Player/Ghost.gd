extends Sprite2D

@onready var point_light_2d = $PointLight2D

func _ready():
	ghosting()

func set_property(tx_pos, tx_scale, tx_flip, tx_col):
	position = tx_pos
	scale = tx_scale
	flip_h = tx_flip
	modulate = tx_col
	
func ghosting():
	var tween_fade = get_tree().create_tween()
	var light_fade = get_tree().create_tween()
	tween_fade.tween_property(self, "self_modulate",Color(1, 1, 1, 0), 0.7)
	light_fade.tween_property(point_light_2d, "energy",0, 0.7)
	await tween_fade.finished

	queue_free()
