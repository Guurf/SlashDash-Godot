extends CanvasLayer

func _ready():
	$ColorRect.size = Vector2(640, 360)

func change_scene(target: String) -> void:
	$AnimationPlayer.play("left_wipe")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play("left_wipe_2")

