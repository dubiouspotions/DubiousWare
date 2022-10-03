extends BaseMiniGame

var playerspeed = 6

var boopcount = 0
var poopcount = 0

var boops = []
var poops = []

func getInstruction():
	return "Boop the snoot!"

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
	
var didBoop = false

var hoverlist = []

func getPlayerDidWin():
	return boopcount > 0 and poopcount == 0

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


func hovered_dog() -> Node2D:
	var list = $Cursor/Area2D.get_overlapping_bodies()
	for body in list:
		if body is GoodBoy: return body
		if body is BadDog: return body
	return null
	
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
		
	$Cursor/Area2D.connect("body_entered", self, "did_hover_dog")
	$Cursor/Area2D.connect("body_exited", self, "did_unhover")
	
	boops.shuffle()
	poops.shuffle()
	var lists = [boops, poops]
	lists.shuffle()
	
	$Dogs.add_child(newdog(boops, 0))
	$Dogs.add_child(newdog(boops, 1))
	$Dogs.add_child(newdog(poops, 2))
	$Dogs.add_child(newdog(poops, 3))
	for i in range(4, 12):
		lists.shuffle()
		$Dogs.add_child(newdog(lists[0], i))
	
func next(list: Array) -> Dog:
	var dog = list.pop_front()
	list.push_back(dog)
	return dog

func newdog(list, i) -> Node2D:
	var dog = next(list)
	var node = dog.node()
	var margin = 200
	node.owner = owner
	node.position.x = lerp(margin, 1024-margin, 1.0/3*(i%3))
	node.position.y = lerp(margin, 1024-margin, 1.0/3*(i/3))
	var scale = rand_range(0.2, 0.4)
	scale(node, scale)
	node.gravity_scale = 0
	return node

func scale(node, s):
	for child in node.get_children():
		# Yes this transform is very different from setting child.scale!
		# At least for CollisionShapes
		child.transform = child.transform.scaled(Vector2(s, s))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = get_input_vector()
	$Cursor.translate(input * playerspeed)
	if Input.is_action_just_pressed(self.player_index+"_action"):	
		$Cursor/AnimatedSprite.frame = 0
		$Cursor/AnimatedSprite.play("default")
		var dog = hovered_dog()
		if dog is GoodBoy:
			boopcount += 1
			dog.hide()
			dog.queue_free()
			$BoopSound.play()
		if dog is BadDog:
			poopcount += 1
			$PoopSound.play()
