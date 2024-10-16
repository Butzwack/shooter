extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_pressed():
	get_tree().quit()

func _on_ssao_toggled(toggled_on):
	Global.world_environment.environment.ssao_enabled = toggled_on


func _on_ssr_toggled(toggled_on):
	Global.world_environment.environment.ssr_enabled = toggled_on


func _on_ssil_toggled(toggled_on):
	Global.world_environment.environment.ssil_enabled = toggled_on


func _on_sdfgi_toggled(toggled_on):
	Global.world_environment.environment.sdfgi_enabled = toggled_on


func _on_resolution_item_selected(index):
	print(DisplayServer.window_get_size())
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(3840, 2160))
		1:
			DisplayServer.window_set_size(Vector2i(2560, 1440))
		2:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		3:
			DisplayServer.window_set_size(Vector2i(1280, 800))
		4:
			DisplayServer.window_set_size(Vector2i(1280, 720))


func _on_upscaling_algorithm_item_selected(index):
	match index:
		0:
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_BILINEAR
		1:
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_FSR
		2:
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_FSR2

func _on_resolution_scale_value_changed(value):
	get_viewport().scaling_3d_scale = value

func _on_msaa_item_selected(index):
	match index:
		0:
			get_viewport().msaa_3d = Viewport.MSAA_DISABLED
		1:
			get_viewport().msaa_3d = Viewport.MSAA_2X
		2:
			get_viewport().msaa_3d = Viewport.MSAA_4X
		3:
			get_viewport().msaa_3d = Viewport.MSAA_8X


func _on_taa_toggled(toggled_on):
	get_viewport().use_taa = toggled_on


func _on_fxaa_toggled(toggled_on):
	get_viewport().screen_space_aa = toggled_on


func _on_vsync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
