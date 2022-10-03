extends KinematicBody2D


func _ready():
	pass # Replace with function body.

export (int) var speed = 250
var Velocity = Vector2()
var dead = false

func _physics_process(delta):
	if dead:
		return
		
		
	if Input.is_action_pressed(self.get_parent().player_index+"_left"):
		Velocity.x = -speed
		$AnimatedSprite.play("left")
	elif Input.is_action_pressed(self.get_parent().player_index+"_right"):
		Velocity.x = speed
		$AnimatedSprite.play("right")
	else:
		if $AnimatedSprite.animation == "right":
			$AnimatedSprite.play("right", true)	
		if $AnimatedSprite.animation == "left":
			$AnimatedSprite.play("left", true)	
		Velocity.x = 0
	
	if Input.is_action_pressed(self.get_parent().player_index+"_up"):
		Velocity.y = -speed
		$AnimatedSprite.play("forward")
	elif Input.is_action_pressed(self.get_parent().player_index+"_down"):
		Velocity.y = speed
		$AnimatedSprite.play("backward")
	else:
		Velocity.y = 0
		
	if Velocity.x == 0 && Velocity.y == 0:
		$AnimatedSprite.play("idle")
		
	if Input.is_action_pressed(self.get_parent().player_index+"_action"):
		print(str(delta)+" lol "+self.get_parent().player_index)
		
	move_and_slide(Velocity, Vector2(0,0), false, 4, 0.785, false)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
#		if collision.collider.is_in_group("Walls"):
#			print("collided wioth", collision.collider.name)
		
		$AnimatedSprite.play("death")
		$AudioStreamPlayer.play()
		dead = true
