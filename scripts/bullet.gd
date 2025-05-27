extends CharacterBody2D

@onready var main: Node = get_tree().current_scene
@onready var player: CharacterBody2D = main.get_node("PlayerStuff/Player")

var max_speed: int = 200
var acceleration: float = 30

func _ready():
	rotation_degrees = player.rotation_degrees + 90


func _physics_process(_delta: float):
	velocity += Vector2(0, 1).rotated(rotation - deg_to_rad(180)) * acceleration
	velocity = velocity.limit_length(max_speed)
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		area.call_deferred("split_in_two")
		queue_free()
