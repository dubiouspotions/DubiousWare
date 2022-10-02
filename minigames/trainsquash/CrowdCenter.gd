extends Sprite

var train
	
func _process(delta):
	self.offset.y = rand_range(-2.0, 2.0)
