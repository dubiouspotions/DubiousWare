class_name Commuter
extends RigidBody2D

var game
var train
var commuterTarget
# Called when the node enters the scene tree for the first time.
func _ready():
	train = game.find_node("Train") as Train
	commuterTarget = game.find_node("CommuterIdleTarget")
	
func _integrate_forces(state):
	var speed = 1
	var target = commuterTarget.global_position
	if train.arrived:
		target = train.global_position
	var v = state.linear_velocity
	var u = (target - state.transform.origin) * speed
	var f = u - v
	state.add_central_force(f * self.mass)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.offset.y = rand_range(-2.0, 2.0)
	if position.y < 10:
		hide()
		queue_free()
