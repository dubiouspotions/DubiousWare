extends BaseMiniGame

var loosepieces:Array

func getPlayerDidWin():
	return loosepieces.size() == 0
func getInstruction():
	return "BUILD THE BUG!"
# Called when the node enters the scene tree for the first time.
func _ready():
	var pieces = $board/pieces.get_children()
	pieces.shuffle()
	loosepieces = pieces.slice(0,difficulty/1.6)
	for piece in loosepieces:
		piece.original_transform = piece.transform
		piece.transform = $board/pile.transform
		
var winplayed = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	if loosepieces.empty():
		if winplayed == false:
			$win.play()
			winplayed = true
		return
	var selected_piece:Piece = loosepieces.front()
	if not selected_piece:
		return
	var movement = get_input_vector()*delta*1400
	selected_piece.translate(movement)
	selected_piece.highlight()
	selected_piece.set_z_index(100) 
	
	if selected_piece.transform.get_origin().distance_to(selected_piece.original_transform.get_origin()) < 50:
		selected_piece.transform = selected_piece.original_transform
		loosepieces.pop_front()
		selected_piece.dehighlight()
		selected_piece.set_z_index(0)
		$AudioStreamPlayer.play()
	
	if Input.is_action_pressed(self.player_index+"_action"):
		pass

