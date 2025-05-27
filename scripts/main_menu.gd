extends Control

@onready var ui_animation: AnimationPlayer = $UI
@onready var title_idle_animation: AnimationPlayer = $TitleIdle
@onready var button_animation: AnimationPlayer = $Buttons

var game: PackedScene = preload("res://scenes/main.tscn")
var small_ast_scene: PackedScene = preload("res://scenes/asteroid-small.tscn")
var medium_ast_scene: PackedScene = preload("res://scenes/asteroid-medium.tscn")
var big_ast_scene: PackedScene = preload("res://scenes/asteroid-big.tscn")
var asteroids: Array[PackedScene] = [small_ast_scene, medium_ast_scene, big_ast_scene]

func _process(_delta: float) -> void:
	if not button_animation.is_playing() and Input.is_action_just_pressed("shoot"):
		ui_animation.stop()
		$Play.visible = true
		$Settings.visible = true
		$Title.modulate.a = 1.0
		$Play.modulate.a = 1.0
		$Settings.modulate.a = 1.0
		title_idle_animation.play("idle")
		button_animation.play("idle")


func start_animations() -> void:
	ui_animation.play("ascend_title")
	if not $Play.visible:
		ui_animation.queue("pop_in_buttons")
	

func start_title_idle() -> void:
	title_idle_animation.play("idle")


func start_button_idle() -> void:
	button_animation.play("idle")


func _on_asteroid_timer_timeout() -> void:
	$Asteroids.add_child(asteroids[randi_range(0, 2)].instantiate())


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(game)


func _on_settings_pressed() -> void:	
	pass # TODO: this shit
