extends Control

@export var scene_root_node: Control
@onready var main_menu_node: Control = get_node("/root").get_node_or_null("MainMenu")
@onready var game_scene_node: Node2D = get_node("/root").get_node_or_null("Main")

@onready var vsync_toggle: CheckButton = $VSyncToggle
@onready var screen_shake_toggle: CheckButton = $ScreenShakeToggle
@onready var hurricane_mode_toggle: CheckButton = $HurricaneModeToggle

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		exit_settings()

func _ready() -> void:
	match Settings.vsync_on:
		true:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
			vsync_toggle.button_pressed = true
		
		false:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
			vsync_toggle.button_pressed = false

	match Settings.screen_shake_on:
		true:
			screen_shake_toggle.button_pressed = true
		
		false:
			screen_shake_toggle.button_pressed = false
			
	match Settings.hurricane_mode:
		true:
			hurricane_mode_toggle.button_pressed = true
			
		false:
			hurricane_mode_toggle.button_pressed = false
	
	
func exit_settings() -> void:
	Settings.save_settings()

	scene_root_node.visible = false
	var buttons = get_tree().get_nodes_in_group("button")
	for button in buttons:
		button.disabled = true
		
	if main_menu_node != null:
		main_menu_node.visible = true

		var main_menu_buttons = main_menu_node.get_tree().get_nodes_in_group("button")
		for button in main_menu_buttons:
			button.disabled = false

	if game_scene_node != null:
		game_scene_node.pause_label.visible = true
		game_scene_node.resume_button.visible = true
		game_scene_node.pause_settings_button.visible = true
		game_scene_node.pause_main_menu_button.visible = true

		var game_scene_buttons = game_scene_node.get_tree().get_nodes_in_group("button")
		for button in game_scene_buttons:
			button.disabled = false
			
	queue_free()


func _on_return_pressed() -> void:
	SFXManager.click.play()
	exit_settings()


func _on_v_sync_toggle_toggled(toggled_on: bool) -> void:
	SFXManager.click.play()

	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		Settings.vsync_on = true
		
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		Settings.vsync_on = false

	Settings.save_settings()


func _on_screen_shake_toggle_toggled(toggled_on: bool) -> void:
	SFXManager.click.play()

	if toggled_on:
		Settings.screen_shake_on = true
	
	else:
		Settings.screen_shake_on = false

	Settings.save_settings()


func _on_hurricane_mode_toggle_toggled(toggled_on: bool) -> void:
	SFXManager.click.play()

	if toggled_on:
		Settings.hurricane_mode = true
	
	else:
		Settings.hurricane_mode = false

	Settings.save_settings()
