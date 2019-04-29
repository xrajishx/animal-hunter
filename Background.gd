extends Node

var current_level = global.current_level if global.current_level else 1
var background_image_base_path_format = "res://assets/third_party/free-cartoon-forest-game-backgrounds/PNG/Cartoon_Forest_BG_0%d/Layers/"

func _ready():
	var background_image_base_path = background_image_base_path_format % current_level
	$Layer0/TextureRect.texture = load(background_image_base_path + "Sky.png")
	$Layer2/TextureRect.texture = load(background_image_base_path + "BG_Decor.png")
	$Layer4/TextureRect.texture = load(background_image_base_path + "Middle_Decor.png")
	$Layer6/TextureRect.texture = load(background_image_base_path + "Foreground.png")
	$Layer8/TextureRect.texture = load(background_image_base_path + "Ground.png")