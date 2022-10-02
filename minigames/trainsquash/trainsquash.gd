extends BaseMiniGame

const train_target = 260
const train_enter = 1000
const train_exit = -1000
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var gametime = 0.0
var anim: float = 0.0
var started = false

var doors_duration = 0.5
var train_duration = 1.0
var train_arrival_time: float = 0.0
var train_departure_time: float = 9.0
var train_entered = false
var train_left = false

var door_travel = 25

var tween = Tween.new()
var tween2 = Tween.new()


func schedule(time, method):
	var timer = Timer.new()
	add_child(timer)
	timer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	timer.one_shot = true
	timer.wait_time = time
	timer.connect("timeout", self, method)
	timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(tween)
	add_child(tween2)
	gen_crowd()
	
	enter_train()

	schedule(train_arrival_time + train_duration, "open_doors")
	schedule(train_departure_time - doors_duration*2, "close_doors")
	schedule(train_departure_time, "exit_train")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gametime += delta
	

func enter_train():
	var y = $Train.position.y
	tween.interpolate_property(
		$Train, "position", 
		Vector2(train_enter, y), 
		Vector2(train_target, y), 
		train_duration,
		Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	tween.start()

func exit_train():
	var y = $Train.position.y
	tween.interpolate_property(
		$Train, "position", 
		Vector2(train_target, y), 
		Vector2(train_exit, y), 
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
	
func gen_crowd():
	var crowd = $Platform/GameArea/Commuters
	var cs = load("res://minigames/trainsquash/Commuter.tscn")
	for i in range(0, 2):
		var commuter = cs.instance()
		commuter.game = self
		
		commuter.position = Vector2(
			rand_range(-50, 50.0),
			rand_range(46.0, 200.0)
		)
		crowd.add_child(commuter)
		printt(commuter.position)
		
