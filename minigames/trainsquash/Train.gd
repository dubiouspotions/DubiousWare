class_name Train
extends Node2D

var commuters_required = 75
var boarded_commuters = 0

# Declare member variables here. Examples:
var doors_open = false
var arrived = false

var door_travel = 25
var full = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func commuter_boarded():
	boarded_commuters += 1
	$FillPlayer.seek(float(boarded_commuters)/float(commuters_required))
	full = boarded_commuters >= commuters_required
	if full:
		depart()

func arrive():
	if not arrived:
		$AnimationPlayer.play("Arrive")

func depart():
	if arrived:
		$AnimationPlayer.play("Depart")

func did_arrive():
	arrived = true
	
func will_depart():
	arrived = false
