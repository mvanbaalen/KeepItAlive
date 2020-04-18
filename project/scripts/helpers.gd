extends Node


const vowels = ['a', 'e', 'i', 'o', 'u']
const consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p',
					 'q', 'r', 's', 't', 'v', 'w', 'x', 'z']


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func random_sample(array):
	return array[randi() % array.size()]

func generate_name():
	return random_sample(consonants) + random_sample(vowels) + random_sample(consonants)
	
