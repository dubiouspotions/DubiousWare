extends BaseMiniGame


func getPlayerDidWin():
	return $PlayerShip.are_you_winning_son

func getInstruction():
	return "Rescue the diamond!"

# Called when the node enters the scene tree for the first time.
func _ready():
	$planets/Planet.r_speed =  0.5 + difficulty/5.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
