extends BaseMiniGame

export var SCORE = 0
var win_score = 3
var rotation_speed = 20

var _needle = load("res://minigames/vodo/needle_scn.tscn")

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
				if 90 - int($Doll.rotation_degrees) % 90 < 10 or int($Doll.rotation_degrees) % 90 < 10:
					success()
				else:
					fail()

func fail():
	current_needle.fail()
	$Timer.start(2)

func success():
	current_needle.success()
	SCORE += 1
	$Doll/AnimatedDoll.scale.x -= 0.1
	$Doll/AnimatedDoll.scale.y -= 0.1
	new_needle()
	if SCORE >= win_score:
		current_needle.visible = false
		for needle in $Needles.get_children():
			if (needle.STATE != "HIT"):
				needle.visible = false
		$Doll/Circle.visible = false
		$Doll/AnimatedDoll.play("evil")

func _on_Timer_timeout():
	new_needle()
	pass # Replace with function body.
