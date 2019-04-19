extends Node2D

export var speed = 400

signal animal_hit

var screen_size
var animal_direction

func _ready():
	screen_size = get_viewport_rect().size
	connect("animal_hit", get_node("/root/Main"), "animal_hit")

func init(direction):
	animal_direction = direction

func _process(delta):
	var velocity = Vector2()
	velocity.x += 1
	
	velocity = velocity.normalized() * speed
	position += (velocity * delta) if animal_direction == 0 else -(velocity * delta)

func _on_TextureButton_pressed():
	emit_signal("animal_hit")
	queue_free()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
