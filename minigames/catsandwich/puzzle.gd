extends BaseMiniGame

var max_x = 800
var min_x = 200
var velocity = 500
var fall_speed = 600
var spawns = [ 1, 4, 1, 7, 3, 10, 6, 5, 8, 0]
var frames = [11,10, 9, 8, 7,  6, 5, 4, 3, 2]

var spawn_counter = 0
var SCORE = 0
var win_score = 5

var state = "RUNNING"

var part_height = 60

var _sandwichPart = load("res://minigames/catsandwich/SandwichPart.tscn")

func getPlayerDidWin():
	if SCORE >= win_score:
		return true
	return false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed(self.player_index+"_left"):	
		$Plate.position.x -= delta * velocity
	if Input.is_action_pressed(self.player_index+"_right"):	
		$Plate.position.x += delta * velocity
	if $Plate.position.x < min_x:
		$Plate.position.x = min_x
	elif $Plate.position.x > max_x:
		$Plate.position.x = max_x
	
	for part in $SandwichParts.get_children():
		if part.state == "FALING" or part.state == "FAIL":
			part.position.y += delta * fall_speed
		if state == "RUNNING" and part.state == "FALING":
			if abs(part.position.y - $Plate.position.y + (SCORE + 0.5) * part_height) < 20:
				if abs(part.position.x - $Plate.position.x) < 100:
					part.success(not (SCORE >= win_score-1))
					part.position.y = $Plate.position.y - (SCORE + 0.5) * part_height
					success()
			if part.position.y > 950:
				part.fail()
				part.queue_free()
		if part.state == "CATCHED":
			part.position.x = $Plate.position.x

func success():
	SCORE += 1
	if SCORE >= win_score:
		state = "WON"
		fall_speed = 100

		var part1 = _sandwichPart.instance()
		part1.set_frame(0)
		part1.success()
		$SandwichParts.add_child(part1)
		part1.position.y = $Plate.position.y - (SCORE + 1.5) * part_height

		var part2 = _sandwichPart.instance()
		part2.set_frame(1)
		part2.success(false)
		$SandwichParts.add_child(part2)
		part2.position.y = $Plate.position.y - (SCORE + 0.5) * part_height

func _on_SpawnTimer_timeout():
	var part = _sandwichPart.instance()
	part.position.x = 200 + (1024.0-400.0)/10.0 * spawns[spawn_counter]
	part.set_frame(frames[spawn_counter])
	$SandwichParts.add_child(part)
	spawn_counter += 1
	if spawn_counter > 9:
		$SpawnTimer.stop()
