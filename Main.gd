extends Node2D

signal remaining_to_kill_changed
signal remaining_time_changed
signal game_start
signal game_over

var animal_scene = preload("res://Animal.tscn")

var screen_size
var level_info = global.levels[global.current_level - 1]
var remaining_time = level_info.time_to_kill
var remaining_to_kill = level_info.animals_to_kill

var bear = preload("res://assets/third_party/kenney_animalpackredux/PNG/Round/bear.png")
var parrot = preload("res://assets/third_party/kenney_animalpackredux/PNG/Round/parrot.png")
var rabbit = preload("res://assets/third_party/kenney_animalpackredux/PNG/Round/rabbit.png")

func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	$GameStartTimer.start()
	$AnimalSpawnTimer.start()
	
func _on_HUD_play_again():
	global.goto_scene("res://Menu.tscn")

func _on_AnimalSpawnTimer_timeout():
	spawn_animal()
	
func _on_GameStartTimer_timeout():
	$GameTimer.start()
	emit_signal("game_start")

func _on_GameTimer_timeout():
	remaining_time -= 0.1
	remaining_time = abs(remaining_time)
	emit_signal("remaining_time_changed", remaining_time)
	if("%.1f" % remaining_time == "0.0"):
		game_over(0)

func _on_Music_finished():
	$Music.play()

func on_Animal_hit():
	remaining_to_kill -= 1
	emit_signal("remaining_to_kill_changed", remaining_to_kill)
	if(remaining_to_kill == 0):
		game_over(1)
	
func game_over(result):
	$AnimalSpawnTimer.stop()
	$GameTimer.stop()
	emit_signal("game_over", result)
	
func randomize_enemy_spawn():
	return {
		"layer": ((randi() % 3) * 2) + 5, # Will be either 5, 7 or 9
		"y": (randi() % 5) * (screen_size.y / 5),
		"direction": randi() % 2
	}
	
func _input(event):
    if event is InputEventScreenTouch and event.pressed:
        $Shoot.play()

func random_animal(y):
	var yPosition = y / screen_size.y * 5
	var random_factor = (randi() % 2) + 1
	
	if(yPosition == 0):
		return parrot
	elif(yPosition == 1):
		return parrot if random_factor == 0 else bear
	elif(yPosition == 2):
		return bear
	elif(yPosition == 3):
		return rabbit if random_factor == 0 else bear
	else:
		return rabbit

func spawn_animal():
	var random_enemy_spawn_values = randomize_enemy_spawn()
	var animal = animal_scene.instance()
	var animal_clickable = animal.get_child(0)
	var animal_size
	var canvas_layer = CanvasLayer.new()
	var spawnX
	var spawnY
	
	spawnY = random_enemy_spawn_values.y
	
	animal.init(random_enemy_spawn_values.direction)

	animal_clickable.texture_normal = random_animal(spawnY)
	animal.scale.x = animal.scale.x + (0.1 * (random_enemy_spawn_values.layer - 9))
	animal.scale.y = animal.scale.y + (0.1 * (random_enemy_spawn_values.layer - 9))
	animal_size = animal_clickable.texture_normal.get_size()
	
	spawnX = -animal_size.x if random_enemy_spawn_values.direction == 0 else screen_size.x + animal_size.x
	
	animal.position = Vector2(spawnX, spawnY)

	canvas_layer.add_child(animal)
	canvas_layer.layer = random_enemy_spawn_values.layer
	
	$Background.add_child(canvas_layer)

