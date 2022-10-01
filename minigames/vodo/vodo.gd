extends BaseMiniGame

export var SCORE = 0
var rotation_speed = 20

var _needle = load("res://minigames/vodo/needle_scn.tscn")

var current_needle

func getPlayerDidWin():
	return false

func new_needle():
	current_needle = _needle.instance()
	current_needle.position.x = 512
	current_needle.position.y = 650
	current_needle.rotation_speed = rotation_speed
	add_child(current_needle)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_needle()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Doll.rotation_degrees += delta * rotation_speed
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
	$Timer.start(3)

func success():
	current_needle.success()
	SCORE += 1
	new_needle()

func _on_Timer_timeout():
	new_needle()
	pass # Replace with function body.
