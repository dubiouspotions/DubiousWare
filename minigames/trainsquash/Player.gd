extends KinematicBody2D

var speed = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = 0
	var input = owner.get_input_vector()
	self.translate(input * speed)
	var train = owner.get_node("Train")
	var doors = train.global_position
	look_at(doors)
	rotate(PI/2)
