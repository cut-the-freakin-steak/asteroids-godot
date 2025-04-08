extends Asteroid

var rotation_speed: int = randi_range(1, 2)

func _process(delta: float) -> void:
  super(delta)
  rotation += rotation_speed * delta

  position.x += randi_range(15, 30) * direction.x * delta
