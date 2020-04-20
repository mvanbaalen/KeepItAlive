extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_new_planet()


func _on_continue_button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Game.tscn")


func populate_labels():
	#We're really running out of the time now...
	$Label.text = "Planet " + Planet.planet_name
	$VBoxContainer/Creature1/Name.text = Planet.life[0].get_description() + " " + "\"" + Planet.life[0].name + "\""
	$VBoxContainer/Creature1/Count.text = str(Planet.life[0].number)
	$VBoxContainer/Creature2/Name.text = Planet.life[1].get_description() + "\"" + Planet.life[1].name + "\""
	$VBoxContainer/Creature2/Count.text = str(Planet.life[1].number)
	$VBoxContainer/Creature3/Name.text = Planet.life[2].get_description() + "\"" + Planet.life[2].name + "\""
	$VBoxContainer/Creature3/Count.text = str(Planet.life[2].number)
	
func _on_another_button_pressed():
	generate_new_planet()
	
func generate_new_planet():
	Planet.new_planet()
	populate_labels()
