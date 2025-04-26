extends Node2D

signal game_over
signal asteroid_hit(asteroid_size: String, position: Vector2)

@onready var player: CharacterBody2D = $PlayerStuff/Player
@onready var game_over_text: Label = $UI/GameOver
@onready var try_again_button: Button = $UI/TryAgain
@onready var main_menu_button: Button = $UI/MainMenu
@onready var ui_animation: AnimationPlayer = $UI/UIAnimation
@onready var game_over_label_animation: AnimationPlayer = $UI/GameOverAnimation
@onready var game_over_buttons_animation: AnimationPlayer = $UI/ButtonAnimation
@onready var game_over_animation_timer: Timer = $UI/GameOverAnimTimer
@onready var score_label: Label = $UI/ScoreText
@onready var explosion_parts: GPUParticles2D = $AsteroidExplosion

var small_ast_scene: PackedScene = preload("res://scenes/asteroid-small.tscn")
var medium_ast_scene: PackedScene = preload("res://scenes/asteroid-medium.tscn")
var big_ast_scene: PackedScene = preload("res://scenes/asteroid-big.tscn")
var asteroids: Array[PackedScene] = [small_ast_scene, medium_ast_scene, big_ast_scene]

var laser: PackedScene = preload("res://scenes/bullet.tscn")
var score: int = 0

func _ready():
	game_over.connect(_on_game_over)
	asteroid_hit.connect(_spawn_asteroid)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and player.alive and player.shoot_timer.time_left == 0:
		var new_laser: CharacterBody2D = laser.instantiate()
		new_laser.global_position = player.get_node("ShootOrigin").global_position
		$Lasers.add_child(new_laser)
		player.shoot_timer.start()
		
	score_label.text = "Score: " + str(score)


func pop_in_buttons() -> void:
	ui_animation.play("pop_in_game_over_buttons")
	# also play animation for label moving around
	game_over_label_animation.play("idle")
		

func button_idle_animation() -> void:
	game_over_buttons_animation.play("idle")
	
	
func _spawn_asteroid(asteroid_size: String, ast_position: Vector2) -> void:
	explosion_parts.global_position = ast_position
	explosion_parts.emitting = true
	
	if asteroid_size == "big":
		var new_ast1: Asteroid = medium_ast_scene.instantiate()
		var new_ast2: Asteroid = medium_ast_scene.instantiate()
		new_ast1.use_set_position = true
		new_ast2.use_set_position = true
		new_ast1.global_position = ast_position
		new_ast2.global_position = ast_position
		$Asteroids.call_deferred("add_child", new_ast1)
		$Asteroids.call_deferred("add_child", new_ast2)
	
	elif asteroid_size == "medium":
		var new_ast1: Asteroid = small_ast_scene.instantiate()
		var new_ast2: Asteroid = small_ast_scene.instantiate()
		new_ast1.use_set_position = true
		new_ast2.use_set_position = true
		new_ast1.global_position = ast_position
		new_ast2.global_position = ast_position
		$Asteroids.call_deferred("add_child", new_ast1)
		$Asteroids.call_deferred("add_child", new_ast2)
		
	else:
		pass


func _on_game_over() -> void:
	game_over_text.visible = true
	ui_animation.play("appear_game_over_text")
	game_over_animation_timer.start()
		

func _on_asteroid_timer_timeout() -> void:
	$Asteroids.add_child(asteroids[randi_range(0, 2)].instantiate())


func _on_game_over_anim_timer_timeout() -> void:
	ui_animation.play("ascend_game_over_text")
