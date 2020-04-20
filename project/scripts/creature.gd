extends Node

enum SIZE {SMALL, MEDIUM, LARGE}
enum TYPE {PLANT, ANIMAL}

signal updated

var size
var type
var eats
var number=1 setget set_number
var number_on_next_tick # oops we need a buffer?

func _init():
	name = Helpers.generate_name()
	
func randomize_size():
	size = Helpers.random_type(SIZE)

func set_properties(new_size, new_type, new_eats):
	size = new_size
	type = new_type
	eats = new_eats

func randomize_properties():
	set_properties(Helpers.random_type(SIZE),
					Helpers.random_type(TYPE),
					Helpers.random_type(TYPE))

func set_number(new_value):
	number = clamp(new_value, 0, new_value)
	if number == 0:
		Planet.creature_died(self)#signals...
	emit_signal("updated")
	
func get_full_type():
	if type == TYPE.PLANT:
		return "Plant"
	else:
		if eats == TYPE.PLANT:
			return "Herbivore"
		else:
			return "Carnivore"
			
func get_description():
	return SIZE.keys()[size].capitalize() + " " + get_full_type()
	
func get_icon():
	var first_letter = SIZE.keys()[size].capitalize().substr(0, 1)
	var second_letter = get_full_type().substr(0, 1)
	return first_letter + "/" + second_letter
	
