extends BaseMiniGame

var _timer = null
onready var _snapshot = $snapshots
onready var _overlays = $overlays
onready var _currentFrame = 1
var _hasPlayerSucceeded = false
var _hasPlayerSelected = false
var _randomNumberArray = [0,1,2,3,4,5,6,7,8,9]



func getPlayerDidWin():
	return _hasPlayerSucceeded

func getInstruction():
	return "Snap the group selfie!"
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var frames = [10]
	_randomNumberArray.shuffle()
	for i in range(0, 1 + difficulty):
		if not _randomNumberArray.empty():
			var frame = _randomNumberArray.pop_front()
			frames.push_back(frame)
	frames.shuffle()
	_randomNumberArray = frames
	print(_randomNumberArray)
	$overlays.hide()
	
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	pass

func _on_Timer_timeout():
	#_overlays.hide()
	_currentFrame = _randomNumberArray.pop_front()
	_randomNumberArray.push_back(_currentFrame)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	if _hasPlayerSelected:
		return false
	
	_snapshot.frame = _currentFrame
	
	if Input.is_action_pressed(self.player_index+"_action"):
		_overlays.frame = _currentFrame
		_overlays.show()
		
		_hasPlayerSelected = true
		## player has won - they're on the right frame and have snapped the photo
		if (_currentFrame == 10):
			_timer.stop()
			_hasPlayerSucceeded = true
		else:
			#play buzzer sound
			pass
			
