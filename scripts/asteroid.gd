extends Area2D
class_name Asteroid

var direction: Vector2 = Vector2(0, 0)
var vertical_speed: float = 0

func _ready() -> void:
  randomize()

  var main: Node = get_tree().current_scene

  var asteroid_markers: Array[Node] = main.get_node("AsteroidMarkers").get_children()
  var selected_asteroid_spawn: Marker2D = asteroid_markers[randi() % asteroid_markers.size()]
  
  position = selected_asteroid_spawn.position
  
  if position.x <= 0:
    direction.x = 1
    
  else:
    direction.x = -1

  if position.y <= 0:
    direction.y = 1
    
  else:
    direction.y = -1
    
  var vert_speed_coin_flip: int = randi_range(0, 1)

  if vert_speed_coin_flip == 0:
    vertical_speed = randi_range(20, 40) * direction.y
    
  else:
    vertical_speed = randi_range(45, 60) * direction.y


func _process(delta: float) -> void:  
  position.y += vertical_speed * delta

  if position.x > 250 or position.x < -50:
    queue_free()
    
  if position.y > 250 or position.y < -50:
    queue_free()
