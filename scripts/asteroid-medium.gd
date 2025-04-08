extends Asteroid

var rotation_speed: int = randi_range(2, 3)

func _process(delta: float) -> void:
  super(delta)
  rotation += rotation_speed * delta

  position.x += randi_range(30, 40) * direction.x * delta
