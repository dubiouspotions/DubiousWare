extends BaseMiniGame

var isWinning = true

func getPlayerDidWin():
	return isWinning
func getInstruction():
	return "Don't get crushed!"

func setPlayerDidWin(win : bool):
	isWinning = win
