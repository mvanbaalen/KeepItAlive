extends Node

enum SIZE {SMALL, MEDIUM, LARGE}
enum TYPE {PLANT, ANIMAL}

signal updated

var size
var type
var eats
var number setget set_number

func _init():
	number = randi() % 2000 + 9000
	name = Helpers.generate_name()

func set_properties(new_size, new_type, new_eats):
	size = new_size
	type = new_type
	eats = new_eats

func randomize_properties():
	set_properties(Helpers.random_type(SIZE),
					Helpers.random_type(TYPE),
					Helpers.random_type(TYPE))

func set_number(new_value):
	number = new_value
	emit_signal("updated")
	
