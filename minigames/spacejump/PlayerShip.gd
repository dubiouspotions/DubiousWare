extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var acceleration = Vector2()
var velocity = Vector2()
const rotation_speed = 10
export var are_you_winning_son = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func lose():
	are_you_winning_son = false
	self.visible = false
	

func _physics_process(delta):
	var input = $"..".get_input_vector()
	self.rotation = self.rotation + input.x * 5 * delta
	
	acceleration.y = input.y * 300
	velocity = velocity + acceleration.rotated(self.rotation)*delta
	move_and_slide(velocity, Vector2(0, -1))
	
	$flame.visible = input.y != 0
	$flame.frame = randi() % 3
	
	if get_slide_count() > 0:
		lose()
	
