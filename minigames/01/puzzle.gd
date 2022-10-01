extends BaseMiniGame


func getPlayerDidWin():
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed(self.player_index+"_left"):
		$Player.translate(Vector2(-delta*400, 0))
	if Input.is_action_pressed(self.player_index+"_right"):
		$Player.translate(Vector2(delta*400, 0))
	if Input.is_action_pressed(self.player_index+"_up"):
		$Player.translate(Vector2(0, -delta*400))
	if Input.is_action_pressed(self.player_index+"_down"):
		$Player.translate(Vector2(0, delta*400))
	if Input.is_action_pressed(self.player_index+"_action"):
		print(str(delta)+" lol "+self.player_index)


	
