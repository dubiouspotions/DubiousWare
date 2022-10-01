class_name Commuter
extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = 0
	$Sprite.offset.y = rand_range(-2.0, 2.0)

	var train = get_tree().root.get_node("Train")
	var doors = train.global_position
	linear_velocity = global_position.direction_to(doors).normalized()
