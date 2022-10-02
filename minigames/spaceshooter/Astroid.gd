extends Node2D

export(String, "1", "2", "3", "4") var version

# Called when the node enters the scene tree for the first time.
func _ready():
	match version:
		"1":
			$Astroid1.show()
		"2":
			$Astroid2.show()
		"3":
			$Astroid3.show()
		_:
			$Astroid4.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
