extends Node

enum SIZE {SMALL, MEDIUM, LARGE}
enum TYPE {PLANT, ANIMAL}

var size
var type

# Called when the node enters the scene tree for the first time.
func _init():
	size = SIZE.SMALL
	type = TYPE.PLANT
	name = Helpers.generate_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
