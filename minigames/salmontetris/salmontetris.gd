extends BaseMiniGame

var isWinning = true

func getPlayerDidWin():
	return isWinning
	
func setPlayerDidWin(win : bool):
	isWinning = win
