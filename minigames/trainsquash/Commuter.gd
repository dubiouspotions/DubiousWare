class_name Commuter
extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game
var train
# Called when the node enters the scene tree for the first time.
func _ready():
	train = game.find_node("Train")


func _integrate_forces(state):
	var speed = 1
	if game != null:
		var doors = train.global_position
		var v = state.linear_velocity
		var u = (doors - state.transform.origin) * speed
		var f = u - v
		state.add_central_force(f * self.mass)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.offset.y = rand_range(-2.0, 2.0)
	pass
	
		
