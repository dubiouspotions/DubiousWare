extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var acceleration = Vector2()
var velocity = Vector2()
var rotation_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = $"..".get_input_vector()
	self.rotation = self.rotation + input.x * 5 * delta
	
	acceleration.y = input.y * 300
	velocity = velocity + acceleration.rotated(self.rotation)*delta
	move_and_slide(velocity, Vector2(0, -1))
	
	$flame.visible = input.y != 0
	$flame.frame = rand_range(0, 3)
