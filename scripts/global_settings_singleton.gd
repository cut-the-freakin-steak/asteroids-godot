extends Node

var settings_save_path = "user://settings.data"
var vsync_on: bool = false
var screen_shake_on: bool = true
var hurricane_mode: bool = false

func save_settings() -> void:
	var file: FileAccess = FileAccess.open(settings_save_path, FileAccess.WRITE)
	file.store_var(vsync_on)
	file.store_var(screen_shake_on)
	file.store_var(hurricane_mode)
	file.close()


func load_settings() -> void:
	if FileAccess.file_exists(settings_save_path):
		var file = FileAccess.open(settings_save_path, FileAccess.READ)
		vsync_on = file.get_var()
		screen_shake_on = file.get_var()
		hurricane_mode = file.get_var()
		file.close()
