extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var distance = 400
export var r_speed = 1.0
export var r_offset = 4.0
var original_transform:Transform2D
var r = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	original_transform = self.transform
	r = r_offset
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	r = r + delta*r_speed
	self.transform =  original_transform * Transform2D().rotated(r).translated(Vector2(distance, 0)) * Transform2D().rotated(-r)

# 
