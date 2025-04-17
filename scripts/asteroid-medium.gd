extends Asteroid

var rotation_speed: int = randi_range(2, 3)

func _ready() -> void:
  super()
  randomize()
  horizontal_speed = randi_range(30, 40) * direction.x


func _physics_process(delta: float) -> void:
  super(delta)
  rotation += rotation_speed * delta

  position.x += horizontal_speed * delta
