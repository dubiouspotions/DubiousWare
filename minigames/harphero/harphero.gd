extends BaseMiniGame

var SCORE = 0
var win_score = 10

var note_vel = 185

var click_pos = 426
var ok_dist = 45

var _note = load("res://minigames/harphero/Note.tscn")

var song = [
	"Left",
	"Right",
	"Left",
	"Left",
	"Right",
	"Left",
	"Left",
	"Left",
	"Up",
	"Right",
	"Up",
	"Right",
	"Left",
	"Down",
	"Up",
	"Up",
	"Down",
	"Down",
	"Right",
	"Left"
]
var note_index = 0

func getPlayerDidWin():
	if SCORE >= win_score:
		return true
	return false

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
			fail_note(note)
		
	$huzzahMeter/huzzahBar.frame = SCORE

func fail():
	if SCORE > 0:
		SCORE -= 1
	pass

func success():
	print("success")
	SCORE += 1

func fail_note(note):
	note.scale.x = 0.5
	note.scale.y = 0.5

func success_note(note):
	note.scale.x = 1.5
	note.scale.y = 1.5

func action(dir):
	print(dir)
	$Mouth.play("hit")
	$Mouth/ResetTimer.start(0.7)
	for note in $Notes.get_children():
		if abs(note.position.y - click_pos) < ok_dist:
			success()
			success_note(note)

func _on_ResetTimer_timeout():
	$Mouth.play("idle")

func _on_NoteTimer_timeout():
	var note = _note.instance()
	note.set_direction(song[note_index])
	$Notes.add_child(note)
	note_index += 1
