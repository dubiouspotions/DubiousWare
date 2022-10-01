extends BaseMiniGame


func getPlayerDidWin():
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var _animated_sprite = $AnimatedSprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	if Input.is_action_pressed(self.player_index+"_action"):
		print("eeeh")
		_animated_sprite.play("cry")
