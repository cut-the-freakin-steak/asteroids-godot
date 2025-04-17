extends CharacterBody2D

@onready var main: Node = get_tree().current_scene
@onready var screen_size: float = get_viewport_rect().size.x

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var sprite_dimensions: Vector2 = get_visible_sprite_dimensions(sprite2d)
@onready var back_particles: GPUParticles2D = $BackFireParticles

@onready var screen_wrap_stuff: Node2D = main.get_node("PlayerStuff/SWStuff")
@onready var opposite_screen_sprite: Sprite2D = main.get_node("PlayerStuff/SWStuff/OtherSideSprite")
@onready var other_side_back_particles: GPUParticles2D = main.get_node("PlayerStuff/SWStuff/OpBackFireParticles")

var max_speed: int = 100
var acceleration: float = 2.5
var rotation_speed: float = 5.5
var ship_on_screen_border_x: bool = false
var ship_on_screen_border_y: bool = false
var last_direction_faced: Vector2
var alive: bool = true

func _physics_process(delta) -> void:
  if not alive:
    return

  # screen wrapping
  if global_position.x - 5 > screen_size:
    global_position.x = 5

  if global_position.x + 5 < 0:
    global_position.x = screen_size - 5

  if global_position.y - 5 > screen_size:
    global_position.y = 5

  if global_position.y + 5 < 0:
    global_position.y = screen_size - 5

  show_screen_wrapped_ship()

  # movement
  var rotation_direction: float = Input.get_axis("left", "right")
  var movement_vector: Vector2 = Vector2(0, Input.get_axis("down", "up"))
  if Input.is_action_pressed("decelerate"):
    movement_vector.y = -1

  if movement_vector.y == 1:
    velocity += movement_vector.rotated(rotation - deg_to_rad(90)) * acceleration
    back_particles.emitting = true

  if movement_vector.y == 0:
    velocity = velocity.move_toward(Vector2.ZERO, 1.3)
    back_particles.emitting = false

  if movement_vector.y == -1:
    velocity = velocity.move_toward(Vector2.ZERO, 3)
    back_particles.emitting = false

  velocity = velocity.limit_length(max_speed)

  rotate(rotation_speed * rotation_direction * delta)

  move_and_slide()


func show_screen_wrapped_ship() -> void:
  # show ship at other side of screen when player going OOB
  # x-axis
  # right
  if global_position.x >= screen_size - (sprite_dimensions.x - sprite_dimensions.x / 2):
    ship_on_screen_border_x = true
    screen_wrap_stuff.global_position = Vector2(position.x - screen_size, position.y)
    opposite_screen_sprite.visible = true
    screen_wrap_stuff.rotation_degrees = rotation_degrees + 90

    if Input.is_action_pressed("up"):
      other_side_back_particles.emitting = true

    else:
      other_side_back_particles.emitting = false

  # left
  elif global_position.x <= 0 + (sprite_dimensions.x / 2):
    ship_on_screen_border_x = true
    screen_wrap_stuff.global_position = Vector2(position.x + screen_size, position.y)
    opposite_screen_sprite.visible = true
    screen_wrap_stuff.rotation_degrees = rotation_degrees + 90

    if Input.is_action_pressed("up"):
      other_side_back_particles.emitting = true

    else:
      other_side_back_particles.emitting = false

  else:
    ship_on_screen_border_x = false
    opposite_screen_sprite.visible = false
    other_side_back_particles.emitting = false

  # y-axis
  # bottom
  if global_position.y >= screen_size - (float(sprite2d.texture.get_height()) / 2 + 8):
    ship_on_screen_border_y = true
    screen_wrap_stuff.global_position = Vector2(position.x, position.y - screen_size)
    opposite_screen_sprite.visible = true
    screen_wrap_stuff.rotation_degrees = rotation_degrees + 90

    if Input.is_action_pressed("up"):
      other_side_back_particles.emitting = true

    else:
      other_side_back_particles.emitting = false

  # top
  elif global_position.y <= 0 + (float(sprite2d.texture.get_height()) / 2 - 8):
    ship_on_screen_border_y = true
    screen_wrap_stuff.global_position = Vector2(position.x, position.y + screen_size)
    opposite_screen_sprite.visible = true
    screen_wrap_stuff.rotation_degrees = rotation_degrees + 90

    if Input.is_action_pressed("up"):
      other_side_back_particles.emitting = true

    else:
      other_side_back_particles.emitting = false

  else:
    ship_on_screen_border_y = false
    if not ship_on_screen_border_x:
      opposite_screen_sprite.visible = false
      other_side_back_particles.emitting = false


func get_visible_sprite_dimensions(sprite: Sprite2D) -> Vector2:
  if sprite.texture == null:
    return Vector2(0, 0)

  var image: Image = sprite.texture.get_image()
  var used_rect: Rect2i = image.get_used_rect()
  var visible_pixels_v2: Vector2 = Vector2(used_rect.size.x, used_rect.size.y)

  return visible_pixels_v2
