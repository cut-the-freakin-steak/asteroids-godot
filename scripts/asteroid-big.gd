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
