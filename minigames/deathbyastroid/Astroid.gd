extends Node2D

export(String, "1", "2", "3", "4") var version

var astroid

export (int) var speed = 300
export (bool) var started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position.y = -100
	match version:
		"1":
			astroid = $Astroid1
		"2":
			astroid = $Astroid2
		"3":
			astroid = $Astroid3
		_:
			astroid = $Astroid4
			
	astroid.show()
	for child in astroid.get_children():
		for collision_shape in child.get_children():
			collision_shape.disabled = false
	


func _process(delta):
	if (started):
		self.position.y = self.position.y + delta * speed
