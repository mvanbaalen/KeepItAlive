extends Node


const vowels = ['a', 'e', 'i', 'o', 'u', 'ai', 'ea', 'ee', 'ia', 'ie', 'oa', 'oo', 'ou']
					
const syl_starts = ['', 'b', 'br', 'bl', 'c', 'd', 'dr', 'f', 'fl', 'fr', 'g', 'j', 'k', 'l', 'm', 'n', 'p', 'r', 's', 't', 'v', 'w', 'z']
const syl_ends = ['', 'b', 'ck', 'd', 'f', 'g', 'l', 'm', 'n', 'ng', 'p', 'r', 's', 't', 'v', 'x', 'z']


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func random_sample(array):
	return array[randi() % array.size()]
	
func random_type(types):
	return types.values()[randi() % types.size()]

func generate_name():
	var new_name = ""
	for _syl in range((randi() % 3) + 1):
		new_name += random_sample(syl_starts) + random_sample(vowels) + random_sample(syl_ends)
	return new_name.capitalize()
	
