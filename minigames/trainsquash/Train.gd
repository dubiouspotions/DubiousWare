class_name Train
extends Node2D

var commuters_required = 30

# Declare member variables here. Examples:
var doors_open = false
var arrived = false

const train_target = 260
const train_enter = 1000
const train_exit = -1000
var doors_duration = 0.5
var train_duration = 1.0
var train_arrival_time: float = 0.0
var train_departure_time: float = 9.0
var train_entered = false
var train_left = false

var door_travel = 25

var tween = Tween.new()
var tween2 = Tween.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(tween)
	add_child(tween2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func arrive():
	var y = position.y
	tween.interpolate_property(
		self, "position:x", 
		train_enter, 
		train_target, 
		train_duration,
		Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	tween.start()

func depart():
	var y = position.y
	tween.interpolate_property(
		self, "position:x", 
		train_target, 
		train_exit,
		train_duration,
		Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tween.start()
	
func open_doors():
	var y = $Train/DoorLeft.position.y
	tween.interpolate_property(
		$Train/DoorLeft, "position", 
		Vector2(0, y), 
		Vector2(-door_travel, y), 
		doors_duration,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	tween.start()
	
	y = $Train/DoorRight.position.y
	tween2.interpolate_property(
		$Train/DoorRight, "position", 
		Vector2(0, y), 
		Vector2(door_travel, y), 
		doors_duration,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	tween2.start()
	
func close_doors():
	var y = $Train/DoorLeft.position.y
	tween.interpolate_property(
		$Train/DoorLeft, "position", 
		Vector2(-door_travel, y), 
		Vector2(0, y), 
		doors_duration,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	tween.start()
	
	y = $Train/DoorRight.position.y
	tween2.interpolate_property(
		$Train/DoorRight, "position", 
		Vector2(door_travel, y), 
		Vector2(0, y), 
		doors_duration,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	tween2.start()
	
