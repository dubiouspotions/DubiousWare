extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var acceleration = Vector2()
var velocity = Vector2()
const rotation_speed = 10
export var are_you_winning_son = false
export var is_alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func lose():
	is_alive = false
	are_you_winning_son = false
	$explosion.emitting = true
	$flame.visible = false
	$"../explosionsound".play()
	yield(get_tree().create_timer(0.2), "timeout")
	$sprite.visible = false
	yield(get_tree().create_timer(1.0), "timeout")
	$explosion.emitting = false
	acceleration = Vector2()

func win():
	$"../blingsound".play()
	$"../pickup/shape".queue_free()
	$"../pickup/sprite".queue_free()
	are_you_winning_son = true
	$"../pickup/winsparkle".emitting = true
	yield(get_tree().create_timer(0.25), "timeout")
	$"../pickup/winsparkle".emitting = false

func _physics_process(delta):
	if is_alive:
		var input = $"..".get_input_vector()
		self.rotation = self.rotation + input.x * 5 * delta
		
		acceleration.y = min(0, input.y) * 600
		velocity = velocity + acceleration.rotated(self.rotation)*delta
		move_and_slide(velocity, Vector2(0, -1))
		
		$flame.visible = input.y < 0
		$flame.frame = randi() % 3
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider == $"../pickup":
				win()
			else:
				lose()
	
