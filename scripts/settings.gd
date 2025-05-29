extends Control

@onready var vsync_toggle: CheckButton = $VSyncToggle
@onready var screen_shake_toggle: CheckButton = $ScreenShakeToggle
@onready var hurricane_mode_toggle: CheckButton = $HurricaneModeToggle

var main_menu_scene: PackedScene = load("res://scenes/main_menu.tscn")

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
			

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		Settings.save_settings()
		get_tree().change_scene_to_packed(main_menu_scene)
			

func _on_v_sync_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		Settings.vsync_on = true
		
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		Settings.vsync_on = false


func _on_screen_shake_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Settings.screen_shake_on = true
	
	else:
		Settings.screen_shake_on = false


func _on_hurricane_mode_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Settings.hurricane_mode = true
	
	else:
		Settings.hurricane_mode = false


func _on_return_pressed() -> void:
	Settings.save_settings()
	get_tree().change_scene_to_packed(main_menu_scene)
