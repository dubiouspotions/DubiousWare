extends BaseMiniGame

export var SCORE = 0
var win_score = 3
var rotation_speed = 40
var deg_opening = 14

var _needle = load("res://minigames/voodoo/needle_scn.tscn")

var current_needle

func getPlayerDidWin():
	if SCORE >= win_score:
		return true
	return false

func new_needle():
	current_needle = _needle.instance()
	current_needle.position.x = 512
	current_needle.position.y = 650
	current_needle.rotation_speed = rotation_speed
	$Needles.add_child(current_needle)

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_speed = 40*(1 + difficulty/7.0)
	new_needle()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Doll.rotation_degrees += delta * rotation_speed
	if SCORE < win_score:
		if Input.is_action_just_pressed(self.player_index+"_action"):	
			if current_needle.STATE == "IDLE":
				current_needle.STATE = "FLYING"
		if current_needle.STATE == "FLYING":
			current_needle.position.y += delta * current_needle.needle_speed
			if current_needle.position.y < 200:
				if 90 - int($Doll.rotation_degrees) % 90 < deg_opening or int($Doll.rotation_degrees) % 90 < deg_opening:
					success()
				else:
					fail()

func fail():
	current_needle.fail()
	$Timer.start(1)

func success():
	current_needle.success()
	SCORE += 1
	new_needle()
	$Timer2.start(0.5)
	if SCORE >= win_score:
		$Doll/AnimatedDoll.play("hit", true)
		current_needle.visible = false
		for needle in $Needles.get_children():
			if (needle.STATE != "HIT"):
				needle.visible = false
		$Doll/Circle.visible = false
	else:
		$Doll/AnimatedDoll.play("hit")

func _on_Timer_timeout():
	new_needle()
	pass # Replace with function body.


func _on_Timer2_timeout():
	if SCORE >= win_score:
		$Doll/AnimatedDoll.play("evil")
	else:
		$Doll/AnimatedDoll.play("default")
	pass # Replace with function body.
