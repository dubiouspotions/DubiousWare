extends BaseMiniGame

var is_happy = true

func getPlayerDidWin():
	return is_happy
	
func getInstruction():
	return "try not to cry"
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("pulse")
	$monster.hide()
	pass # Replace with function body.

onready var _animated_sprite = $AnimatedSprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	if Input.is_action_pressed(self.player_index+"_action"):
		is_happy = false
		_animated_sprite.play("cry")
		$cry.hide()
		$try.hide()
		$monster.show()
