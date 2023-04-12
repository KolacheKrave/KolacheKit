extends ColorRect
signal quick_edit_start

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_QuickEditButton_pressed():
	emit_signal("quick_edit_start")
	pass # Replace with function body.



func _on_IndexToggle_toggled(button_pressed):
	if button_pressed == true:
		$VBoxContainer/HBoxContainer/IndexToggle.text = "  Index Mode: ON  "
		pass
	else:
		$VBoxContainer/HBoxContainer/IndexToggle.text = "  Index Mode: OFF  "
		pass
	pass # Replace with function body.
