extends Node2D
@export var bullet_scene : PackedScene
var bullet
@export var reload = 1.0
@export var bullet_speed = 100.0
@export var bullet_lifetime = 2.0
@export var bullet_infinite : bool
@onready var reload_timer = $"Reload Timer"
@onready var shoot_point = $"Shoot Point"

func _ready():
	reload_timer.stop()
	reload_timer.wait_time = reload
	reload_timer.start()

func _on_reload_timer_timeout():
	var bullet = bullet_scene.instantiate()
	bullet.speed = bullet_speed
	bullet.lifetime = bullet_lifetime
	bullet.infinite = bullet_infinite
	bullet.direction = rotation_degrees - 90
	bullet.position.x = shoot_point.position.x
	bullet.position.y = shoot_point.position.y
	add_child(bullet)

