extends BaseMiniGame

var rng = RandomNumberGenerator.new()

func getPlayerDidWin():
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_then_launch_astroid()

func wait_then_launch_astroid(): 
	var wait = rand_range(0.2, 0.7)
	yield(get_tree().create_timer(wait),"timeout")
	launch_astroid()
	wait_then_launch_astroid()

func launch_astroid(): 
	var astroid = preload("res://minigames/spaceshooter/Astroid.tscn").instance()
	rng.randomize()
	
	var astroidNr = rng.randi_range(1, 4)
	astroid.version = String(astroidNr)
	
	var astroidSpeed = rng.randi_range(200, 400)
	astroid.speed = astroidSpeed
	
	var astroidPosition = rng.randi_range(50, 950)
	astroid.position.x = astroidPosition
	
	astroid.position.y = 0
	astroid.started = true
	add_child(astroid)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return 
	
