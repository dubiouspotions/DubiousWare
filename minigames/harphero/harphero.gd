extends BaseMiniGame

var SCORE = 0
var win_score = 3

func getPlayerDidWin():
	if SCORE >= win_score:
		return true
	return false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed(self.player_index+"_action"):	
		$Mouth.play("default")

func fail():
	pass

func success():
	SCORE += 1
