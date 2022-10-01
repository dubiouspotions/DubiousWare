extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var p1
var p2
var p3
var p4


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload("res://minigames/01/puzzle.tscn")
	p1 = scene.instance()
	p1.player_index = "p1"
	get_tree().get_root().add_child(p1)
	p1.transform = p1.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(100, 100))
	
	p2 = scene.instance()
	p2.player_index = "p2"
	p2.transform = p2.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(1100, 100))
	get_tree().get_root().add_child(p2)

	p3 = scene.instance()
	p3.player_index = "p3"
	p3.transform = p3.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(100, 650))
	get_tree().get_root().add_child(p3)
	
	p4 = scene.instance()
	p4.player_index = "p4"
	p4.transform = p4.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(1100, 650))
	get_tree().get_root().add_child(p4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
