extends Control

@onready var scene_root_node: Node = get_tree().current_scene

@export var ui_animation: AnimationPlayer
@export var title_idle_animation: AnimationPlayer
@export var button_animation: AnimationPlayer

@export var title: Label
@export var play_button: Button
@export var settings_button: Button
@export var quit_button: Button

@export var are_you_sure: Button
@export var no_quit: Button
@export var yes_quit: Button

@export var click_sfx: FmodEventEmitter2D

var game_scene: PackedScene = preload("res://scenes/main.tscn")
var settings_scene: PackedScene = preload("res://scenes/settings.tscn")
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
		quit_button.visible = true
		title.modulate.a = 1.0
		play_button.modulate.a = 1.0
		settings_button.modulate.a = 1.0
		quit_button.modulate.a = 1.0
		title_idle_animation.play("idle")
		button_animation.play("idle")


func start_animations() -> void:
	ui_animation.play("ascend_title")
	if not play_button.visible:
		ui_animation.queue("pop_in_buttons")
	

func start_title_idle() -> void:
	title_idle_animation.play("idle")


func start_button_idle() -> void:
	button_animation.play("idle")


func _on_asteroid_timer_timeout() -> void:
	$Asteroids.add_child(asteroids[randi_range(0, 2)].instantiate())


func _on_play_pressed() -> void:
	click_sfx.play()
	get_tree().change_scene_to_packed(game_scene)


func _on_settings_pressed() -> void:	
	click_sfx.play()
	scene_root_node.visible = false
	var buttons = get_tree().get_nodes_in_group("button")
	for button in buttons:
		button.disabled = true

	get_tree().get_root().add_child(settings_scene.instantiate())


func _on_quit_pressed() -> void:
	click_sfx.play()
	title.visible = false
	play_button.visible = false
	play_button.disabled = true
	settings_button.visible = false
	settings_button.disabled = true
	quit_button.visible = false
	quit_button.disabled = true
	are_you_sure.visible = true
	are_you_sure.disabled = false
	yes_quit.visible = true
	yes_quit.disabled = false
	no_quit.visible = true
	no_quit.disabled = false


func _on_are_you_sure_pressed() -> void:
	click_sfx.play()
	OS.shell_open("https://i.ytimg.com/vi/YSWMYnuOImg/hqdefault.jpg")


func _on_no_quit_pressed() -> void:
	click_sfx.play()
	title.visible = true
	play_button.visible = true
	play_button.disabled = false
	settings_button.visible = true
	settings_button.disabled = false
	quit_button.visible = true
	quit_button.disabled = false
	are_you_sure.visible = false
	are_you_sure.disabled = true
	yes_quit.visible = false
	yes_quit.disabled = true
	no_quit.visible = false
	no_quit.disabled = true


func _on_yes_quit_pressed() -> void:
	click_sfx.play()
	get_tree().quit()
