extends Node2D
var slashed : bool
@onready var animated_sprite = $AnimatedSprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if slashed :
		animated_sprite.play("flash")


func _on_animated_sprite_animation_finished():
	if slashed :
		slashed = false
		animated_sprite.play("default")
