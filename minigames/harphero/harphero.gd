extends BaseMiniGame

var SCORE = 0
var win_score = 3

var note_vel = 80

var _note = load("res://minigames/harphero/Note.tscn")

func getPlayerDidWin():
	if SCORE >= win_score:
		return true
	return false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed(self.player_index+"_action"):	
		$Mouth.play("hit")
		$Mouth/ResetTimer.start(0.7)
	
	for note in $Notes.get_children():
		note.position.y += delta * note_vel

func fail():
	pass

func success():
	SCORE += 1


func _on_ResetTimer_timeout():
	$Mouth.play("idle")

func _on_NoteTimer_timeout():
	print("hej!")
	var note = _note.instance()
	note.set_direction("Left")
	$Notes.add_child(note)
	pass # Replace with function body.
