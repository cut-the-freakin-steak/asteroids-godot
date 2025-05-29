extends Node
 
@onready var window_size = DisplayServer.window_get_size()
 
# DisplayServer.window_get_size()
# DisplayServer.window_set_size()
# DisplayServer.window_get_position()
# DisplayServer.window_set_position()
func _process(_delta):
	# check to see if the window size changes
  if DisplayServer.window_get_size() != window_size:
    # Get the current window width
    var window_w = DisplayServer.window_get_size().x
    # Since the resolution is 1:1; to get the height, divide the width by 1 and multiply by 1
    # Or you can set the resolution width and height as variables, to suit other resolutions.
    var window_h = window_w / 1.0 * 1 # if the aspect ratio would be 1:1, this would be a whole lot more useful lmao
    # Set the window size to the current width and the new height
    DisplayServer.window_set_size(Vector2(window_w, window_h))
    # Change the window_size variable to match the new size
    window_size = DisplayServer.window_get_size()
