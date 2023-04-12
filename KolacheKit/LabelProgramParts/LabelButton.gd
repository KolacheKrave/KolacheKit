extends Button

@export var ButtonTitle = ""
@export var kolacheAmount = 0
@onready var signalTool = get_node("/root/LabelProgram/VBoxContainer/HBoxContainer/")
@onready var rootProgram = get_node("/root/LabelProgram")
var timerFired = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func init(ImportedTitle):
	text = ImportedTitle
	ButtonTitle = ImportedTitle

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("label_buttons", true)
	pass # Replace with function body.

	


func _on_LabelButton_pressed():
	pass # Replace with function body.

func delete_passer(buttonName):
	if buttonName == ButtonTitle:
		kolacheAmount = kolacheAmount - 1
		$Amount.text = "x" + str(kolacheAmount)
		if kolacheAmount == 0:
			$Amount.visible = false
			pass
			

func clear_pressed():
	$Amount.visible = false
	kolacheAmount = 0


func _on_LabelButton_button_up():
	if timerFired == false:
		rootProgram._label_button_pressed(ButtonTitle)
		var passed_amount = rootProgram.indexNumber
		add_to_labled_amount(ButtonTitle,passed_amount)
		pass
	$Timer.stop()
	timerFired = false
	pass # Replace with function body.

func _on_Timer_timeout():
	timerFired = true
	rootProgram.open_add_a_bunch(ButtonTitle)
	pass # Replace with function body.


func _on_LabelButton_button_down():
	$Timer.start()
	timerFired = false
	pass # Replace with function body.

func add_to_labled_amount(passedButtonName,byAmount):
	if passedButtonName == ButtonTitle:
		$Amount.visible = true
		kolacheAmount = kolacheAmount + int(byAmount)
		$Amount.text = "x" + str(kolacheAmount)
	pass
