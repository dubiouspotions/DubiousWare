extends BaseMiniGame

var ellapsedTime = 0
var relativeMarkerPos = -1 # Goes between -1 & 1
var markerSpeed = 5
var markerTravelLength = 700 # (x coordinate)
var markerZero = 512 # (x coordinate)

var markerState = "RUNNING" # RUNNING / PAUSED / WON

func getPlayerDidWin():
	if markerState != "WON":
		return false
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(self.player_index+"_action"):	
		if markerState == "RUNNING":
			if abs(relativeMarkerPos) < 0.1:
				success()
			else:
				fail()
	if markerState == "RUNNING":
		ellapsedTime += delta
		relativeMarkerPos = cos(ellapsedTime * markerSpeed + PI)
		placeMarker()

func fail():
	markerState = "PAUSED"
	$FailureSound.play()
	$PauseTimer.start(3)

func success():
	$SuccessSound.play()
	markerState = "WON"

func placeMarker():
	$"Control/Dabarrow".position.x = markerZero + relativeMarkerPos * 0.5 * markerTravelLength

func _on_PauseTimer_timeout():
	if markerState == "PAUSED":
		markerState = "RUNNING"
