extends Asteroid

var rotation_speed: int = randi_range(1, 2)

func _ready() -> void:
	super()
	randomize()
	horizontal_speed = randi_range(15, 30) * direction.x


func _physics_process(delta: float) -> void:
	super(delta)
	rotation += rotation_speed * delta

	position.x += horizontal_speed * delta
	

func split_in_two() -> void:
	main.score += 1
	main.emit_signal("asteroid_hit", "big", global_position)
	queue_free()
