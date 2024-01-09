extends Node2D

@export var target_scene : PackedScene

func _on_area_2d_area_entered(area):
	var target_scene_path = target_scene.resource_path
	SceneTransition.change_scene(target_scene_path)
