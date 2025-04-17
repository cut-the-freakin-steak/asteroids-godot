extends Area2D
class_name Asteroid

var direction: Vector2 = Vector2(0, 0)
var vertical_speed: float = 0
var horizontal_speed: float = 0

func _ready() -> void:
  randomize()

  var main: Node = get_tree().current_scene

  var asteroid_markers: Array[Node] = main.get_node("AsteroidMarkers").get_children()
  var selected_asteroid_spawn: Marker2D = asteroid_markers[randi() % asteroid_markers.size()]
  
  position = selected_asteroid_spawn.position
  
  if position.x <= 50:
    direction.x = 1
    
  elif position.x >= 150:
    direction.x = -1
    
  else:
    var ones: Array = [-1, 1]
    direction.x = ones[randi() % ones.size()]

  if position.y <= 50:
    direction.y = 1
    
  elif position.y >= 150:
    direction.y = -1
    
  else:
    var ones: Array = [-1, 1]
    direction.y = ones[randi() % ones.size()]
    
  var vert_speed_coin_flip: int = randi_range(0, 1)

  if vert_speed_coin_flip == 0:
    vertical_speed = randi_range(20, 30) * direction.y
    
  else:
    vertical_speed = randi_range(35, 45) * direction.y


func _physics_process(delta: float) -> void:  
  position.y += vertical_speed * delta

  if position.x > 250 or position.x < -50:
    queue_free()
    
  if position.y > 250 or position.y < -50:
    queue_free()
