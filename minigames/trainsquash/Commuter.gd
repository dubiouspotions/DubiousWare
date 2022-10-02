class_name Commuter
extends RigidBody2D

var game
var train
var commuterIdleTarget
var commuterActiveTarget
# Called when the node enters the scene tree for the first time.
func _ready():
	train = game.find_node("Train") as Train
	commuterIdleTarget = game.find_node("CommuterIdleTarget")
	commuterActiveTarget = game.find_node("CommuterActiveTarget")
	
func _integrate_forces(state):
	var speed = 0.4
	var target = commuterIdleTarget.global_position
	if train.arrived:
		target = commuterActiveTarget.global_position
	var v = state.linear_velocity
	var u = (target - state.transform.origin) * speed
	var f = u - v
	state.add_central_force(f * self.mass)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.offset.y = rand_range(-2.0, 2.0)
	if position.y < 10 and train.arrived:
		hide()
		queue_free()
		train.commuter_boarded()
