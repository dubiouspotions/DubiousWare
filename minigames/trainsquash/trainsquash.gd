extends BaseMiniGame


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var gametime = 0.0
var anim: float = 0.0
var started = false

const train_target = 260
const train_enter = 1000
const train_exit = -1000
var doors_duration = 0.5
var train_duration = 1.0
var train_arrival_time: float = 0.0
var train_departure_time: float = 9.0
var train_entered = false
var train_left = false

var train: Train
var grunts = []
	

func getPlayerDidWin():
	return train.full
func getInstruction():
	return "Fill the train!"

func schedule(time, obj, method):
	var timer = Timer.new()
	add_child(timer)
	timer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	timer.one_shot = true
	timer.wait_time = time
	timer.connect("timeout", obj, method)
	timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	train = $Train
	train.commuters_required = 100 + difficulty * 10
	var a: String
	for child in $Platform/GameArea/Player.get_children():
		if child.name.begins_with("Grunt"):
			grunts.push_back(child)
	
	gen_crowd()
	train.arrive()
	schedule(train_departure_time, train, "depart")
	$Platform/GameArea/Player/Area2D.connect("body_entered", self, "grunt")
	
func door_reached(area):
	printt("Door reached!!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gametime += delta

func gen_crowd():
	var crowd = $Platform/GameArea/Commuters
	var cs = load("res://minigames/trainsquash/Commuter.tscn")
	for i in range(0, train.commuters_required):
		var commuter = cs.instance()
		commuter.game = self
		
		commuter.position = Vector2(
			rand_range(-50*2, 50.0*2),
			rand_range(46.0, 200.0)
		)
		#commuter.connect("body_entered", self, "grunt")
		crowd.add_child(commuter)
		

func grunt(node):
	if not node is Commuter: return
	var grunt = grunts[randi()%3] as Node2D
	if not grunt.playing: grunt.play()
