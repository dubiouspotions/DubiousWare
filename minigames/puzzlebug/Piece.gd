extends Sprite
class_name Piece

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var original_transform:Transform2D

func highlight():
	var new_name = self.name+"HL.png"
	self.texture = load("res://minigames/puzzlebug/assets/"+new_name)

func dehighlight():
	var new_name = self.name+".png"
	self.texture = load("res://minigames/puzzlebug/assets/"+new_name)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
