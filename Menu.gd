extends CanvasLayer

var button_image_path_format = "res://assets/third_party/free-cartoon-forest-game-backgrounds/PNG/Cartoon_Forest_BG_0%d/Cartoon_Forest_BG_0%d.png"

func _ready():
	randomize()
	var random_level_for_background = ((randi() % 4) + 1)
	var background_texture = load(button_image_path_format % [random_level_for_background, random_level_for_background])
	$Control/TextureRect.texture = background_texture
	$Popup/TextureRect.texture = background_texture

func _on_TextureButton_pressed(level):
	global.current_level = level
	global.goto_scene("res://Main.tscn")

func _on_Music_finished():
	$Music.play()

func _on_Button_pressed():
	$Popup.popup()

func _on_RichTextLabel_meta_clicked(meta):
	# warning-ignore:return_value_discarded
	OS.shell_open(meta)

func _on_CreditsButton_pressed():
	$Control/MenuContainer.visible = false
	$Popup.popup()

func _on_GoBackButton_pressed():
	$Control/MenuContainer.visible = true
	$Popup.hide()