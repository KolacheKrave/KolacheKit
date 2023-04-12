extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if self.text == str(1):
		self.button_pressed = true
	pass # Replace with function body.


func change_toggle(number):
	if self.text == str(number):
		self.button_pressed = true
	else:
		self.button_pressed = false
