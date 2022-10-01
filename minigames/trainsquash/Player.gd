extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = owner.get_input_vector()

	self.translate(input*2)
	var train = owner.get_node("Train")
	var doors = train.global_position
	look_at(doors)
	rotate(PI/2)
