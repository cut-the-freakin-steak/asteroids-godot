extends Asteroid

var rotation_speed: int = randi_range(4, 5)

func _process(delta: float) -> void:
  super(delta)
  rotation += rotation_speed * delta

  position.x += randi_range(40, 55) * direction.x * delta
