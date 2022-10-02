extends BaseMiniGame

var loosepieces:Array

func getPlayerDidWin():
	return loosepieces.size() == 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var pieces = $board/pieces.get_children()
	pieces.shuffle()
	loosepieces = pieces.slice(0,2)
	for piece in loosepieces:
		piece.original_transform = piece.transform
		piece.transform = $board/pile.transform
		piece.highlight()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	if Input.is_action_pressed(self.player_index+"_action"):
		pass

