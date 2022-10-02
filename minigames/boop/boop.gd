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
			
class Boop:
	extends Dog
class Poop:
	extends Dog
	
var dog: Dog

func glob(path) -> Array:
	var dir = Directory.new()
	var root = "res://minigames/boop/assets/"
	dir.open(root + path)
	dir.list_dir_begin()
	var names = []
	var name = dir.get_next()
	while name != "":
		if name[0] != "." and not name.ends_with("import"):
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
	printt(dog.file, dog.texture())
	$Sprite.set_texture(dog.texture())
	
func next(list: Array) -> Dog:
	var dog = list.pop_front()
	list.push_back(dog)
	return dog


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(self.player_index+"_action"):	
		if dog is Boop:
			print("WIN")
		if dog is Poop:
			print("FAIL")
