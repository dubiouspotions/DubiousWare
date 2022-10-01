class_name BaseMiniGame
extends Node2D


func getPlayerDidWin():
	return false
	
var player_index = "p1"

func get_input_vector() -> Vector2:
	return Input.get_vector(player_index+"_left", player_index+"_right", player_index+"_up", player_index+"_down")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
