extends KinematicBody2D


func _ready():
	pass # Replace with function body.

export (int) var speed = 20
var Velocity = Vector2()

func _physics_process(delta):
	
	if Input.is_action_pressed(self.get_parent().player_index+"_left"):
		Velocity.x = -speed
	elif Input.is_action_pressed(self.get_parent().player_index+"_right"):
		Velocity.x = speed
	else:
		Velocity.x = 0
	
	if Input.is_action_pressed(self.get_parent().player_index+"_up"):
		Velocity.y = -speed
	elif Input.is_action_pressed(self.get_parent().player_index+"_down"):
		Velocity.y = speed
	else:
		Velocity.y = 0
		
	if Input.is_action_pressed(self.get_parent().player_index+"_action"):
		print(str(delta)+" lol "+self.get_parent().player_index)
		
	move_and_slide(Velocity, Vector2(0,0), false, 4, 0.785, false)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Walls"):
			print("collided wioth", collision.collider.name)
