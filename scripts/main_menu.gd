extends Control

@onready var ui_animation: AnimationPlayer = $UI
@onready var title_idle_animation: AnimationPlayer = $TitleIdle
@onready var button_animation: AnimationPlayer = $Buttons

@onready var title: Label = $Title
@onready var play_button: Button = $Play
@onready var settings_button: Button = $Settings

var game_scene: PackedScene = load("res://scenes/main.tscn")
var small_ast_scene: PackedScene = preload("res://scenes/asteroid-small.tscn")
var medium_ast_scene: PackedScene = preload("res://scenes/asteroid-medium.tscn")
var big_ast_scene: PackedScene = preload("res://scenes/asteroid-big.tscn")
var asteroids: Array[PackedScene] = [small_ast_scene, medium_ast_scene, big_ast_scene]

func _ready() -> void:
	Settings.load_settings()

func _process(_delta: float) -> void:
	if not button_animation.is_playing() and Input.is_action_just_pressed("shoot"):
		ui_animation.stop()
		play_button.visible = true
		settings_button.visible = true
		title.modulate.a = 1.0
		play_button.modulate.a = 1.0
		settings_button.modulate.a = 1.0
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
	get_tree().change_scene_to_packed(game_scene)


func _on_settings_pressed() -> void:	
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
