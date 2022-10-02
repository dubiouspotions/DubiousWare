extends BaseMiniGame

var rng = RandomNumberGenerator.new()

func getPlayerDidWin():
	if $Player.dead:
		return false
	return true

func getInstruction():
	return "Watch out!"
	
# Called when the node enters the scene tree for the first time.
func _ready():
	wait_then_launch_astroid()

func wait_then_launch_astroid(): 
	var wait = rand_range(0.2, 0.7)
	yield(get_tree().create_timer(wait),"timeout")
	launch_astroid()
	wait_then_launch_astroid()

func launch_astroid(): 
	var astroid = preload("res://minigames/deathbyastroid/Astroid.tscn").instance()
	rng.randomize()
	
	var astroidNr = rng.randi_range(1, 4)
	astroid.version = String(astroidNr)
	
	var astroidSpeed = rng.randi_range(300, 500)
	astroid.speed = astroidSpeed
	
	var astroidPosition = rng.randi_range(50, 950)
	astroid.position.x = astroidPosition
	
	astroid.position.y = 0
	astroid.started = true
	add_child(astroid)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Stars1.position.y = $Stars1.position.y + 1
	$Stars2.position.y = $Stars2.position.y + 2
	$Stars3.position.y = $Stars3.position.y + 1
