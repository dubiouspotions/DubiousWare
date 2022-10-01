extends BaseMiniGame

const train_target = 260
const train_start = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	gen_crowd()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func gen_crowd():
	var crowd = $Platform/GameArea/Commuters
	var c0 = $Platform/GameArea/Commuters/Commuter0
	for i in range(0, 70):
		var commuter = c0.duplicate()
		#crowd.call_deferred("add_child", commuter)
		crowd.add_child(commuter)
		commuter.position = Vector2(
			rand_range(-50, 50.0),
			rand_range(46.0, 200.0)
		)
		commuter.owner = owner
		printt(commuter.position)
		
