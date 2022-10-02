extends BaseMiniGame

var SCORE = 0
var win_score = 10

var note_vel = 350

var click_pos = 426
var ok_dist = 55

var _note = load("res://minigames/harphero/Note.tscn")

var song = [
	"Left",
	"Gap",
	"Right",
	"Left",
	"Gap",
	"Left",
	"Gap",
	"Up",
	"Down",
	"Gap",
	"Left",
	"Gap",
	"Up",
	"Right",
	"Gap",
	"Up",
	"Gap",
	"Right",
	"Left",
	"Gap",
	"Down",
	"Gap",
	"Up",
	"Up",
	"Gap",
	"Down",
	"Gap",
	"Down",
	"Right",
	"Gap",
	"Left"
]
var note_index = 0

func getPlayerDidWin():
	if SCORE >= win_score:
		return true
	return false
func getInstruction():
	return "Regale the court!"
	
func _ready():
	pass

func _process(delta):
	if SCORE >= win_score and not $huzzahMeter.playing:
		$huzzahMeter.play()
		return false
	
	if Input.is_action_just_pressed(self.player_index+"_action"):	
		success()
	
	if Input.is_action_just_pressed(self.player_index+"_up"):
		action("Up")
	if Input.is_action_just_pressed(self.player_index+"_down"):
		action("Down")
	if Input.is_action_just_pressed(self.player_index+"_left"):
		action("Left")
	if Input.is_action_just_pressed(self.player_index+"_right"):
		action("Right")
	
	for note in $Notes.get_children():
		note.position.y += delta * note_vel
		if note.position.y > click_pos + ok_dist:
			note.fail()
		
	$huzzahMeter/huzzahBar.frame = SCORE

func fail():
	if SCORE > 0:
		SCORE -= 1
	pass

func success():
	print("success")
	SCORE += 1

func action(dir):
	$Mouth.play("hit")
	$Mouth/ResetTimer.start(0.4)
	for note in $Notes.get_children():
		if note.STATE == "IN_PLAY" and abs(note.position.y - click_pos) < ok_dist:
			if note.DIR == dir:
				success()
				note.success()
			else:
				note.fail()

func _on_ResetTimer_timeout():
	$Mouth.play("idle")

func _on_NoteTimer_timeout():
	var dir = song[note_index]
	if dir != "Gap":
		var note = _note.instance()
		note.set_direction(song[note_index])
		$Notes.add_child(note)
	note_index += 1
