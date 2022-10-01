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
	pass

func fail():
	pass

func success():
	SCORE += 1
