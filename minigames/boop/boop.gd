extends BaseMiniGame


var boopcount = 0
var poopcount = 0

var boops = []
var poops = []

class Dog:
	var file: String
	var _tex
	func texture():
		if not _tex: 
			_tex = load(file)
		return _tex

	func node():
		if not _tex:
			_tex = load(file)
		return _tex.instance()
			
class Boop:
	extends Dog
class Poop:
	extends Dog
	
var dog: Dog
var didBoop = false

func getPlayerDidWin():
	return (didBoop and dog is Boop) or (not didBoop and dog is Poop)

func glob(path) -> Array:
	var dir = Directory.new()
	var root = "res://minigames/boop/assets/"
	dir.open(root + path)
	dir.list_dir_begin()
	var names = []
	var name = dir.get_next()
	while name != "":
		if name[0] != "." and name.ends_with("tscn"):
			name = root + path + "/" + name
			print("Found file " + name)
			names.push_back(name)
		name = dir.get_next()
	return names

# Called when the node enters the scene tree for the first time.
func _ready():
	for file in glob("boops"):
		var boop = Boop.new()
		boop.file = file
		boops.push_back(boop)
		
	for file in glob("poops"):
		var poop = Poop.new()
		poop.file = file
		poops.push_back(poop)
	
	boops.shuffle()
	poops.shuffle()
	var lists = [boops, poops]
	lists.shuffle()
	dog = next(lists[0])
	
	add_child(newdog(boops))
	add_child(newdog(boops))
	add_child(newdog(poops))
	add_child(newdog(poops))
	for i in range(0, 6):
		lists.shuffle()
		add_child(newdog(lists[0]))
	
func next(list: Array) -> Dog:
	var dog = list.pop_front()
	list.push_back(dog)
	return dog

func newdog(list) -> Node2D:
	var dog = next(list)
	var node = dog.node()
	var margin = 200
	node.position.x = rand_range(margin, 1024-margin)
	node.position.y = rand_range(margin, 1024-margin)
	var scale = rand_range(0.1, 0.3)
	node.scale = Vector2(scale, scale)
	return node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(self.player_index+"_action"):	
		didBoop = true
		if dog is Boop:
			print("WIN")
		if dog is Poop:
			print("FAIL")
