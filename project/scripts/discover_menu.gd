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


func _on_another_button_pressed():
	Planet.new_planet()
	$Label.text = "Planet " + Planet.planet_name
	
func generate_new_planet():
	Planet.new_planet()
	$Label.text = "Planet " + Planet.planet_name
