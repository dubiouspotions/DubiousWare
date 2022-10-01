extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload("res://minigames/01/puzzle.tscn")
	var p1 = scene.instance()
	get_tree().get_root().add_child(p1)
	p1.transform = p1.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(100, 100))
	
	var p2 = scene.instance()
	p2.transform = p2.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(1100, 100))
	get_tree().get_root().add_child(p2)

	var p3 = scene.instance()
	p3.transform = p3.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(100, 650))
	get_tree().get_root().add_child(p3)
	
	var p4 = scene.instance()
	p4.transform = p4.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(1100, 650))
	get_tree().get_root().add_child(p4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
