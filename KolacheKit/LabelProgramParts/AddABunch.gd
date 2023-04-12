extends Popup


@onready var numButt = load("res://GenericScenes/NumpadButton.tscn")
@onready var delButt = load("res://GenericScenes/DeleteNumber.tscn")
@onready var numpad = $"%Numpad"
@onready var rootProgram = get_node("/root/LabelProgram")
var connectedName = ""
var amount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in 9:
		var numInst = numButt.instantiate()
		numInst.text = str(x + 1)
		numpad.add_child(numInst)
	
	var numInst = numButt.instantiate()
	var delInst = delButt.instantiate()
	numpad.add_child(MarginContainer.new())
	numpad.add_child(numInst)
	numpad.add_child(delInst)
	
	for x in numpad.get_children():
		if x is Button:
			x.connect("pressed",Callable(self,"numpad_key_entered").bind(x.text))
			pass
		else:
			pass
	pass # Replace with function body.

func numpad_key_entered(number):
	if number == " ":
		if $"%LineEdit".text != "":
			$"%LineEdit".text[-1] = ""
	else:
		$"%LineEdit".text += number
		amount = int($"%LineEdit".text)
	pass

func pass_name(passedName):
	connectedName = passedName
	pass


func _on_AddABunch_about_to_show():
	$"%LineEdit".text = ""
	$"%LineEdit".placeholder_text = "How Many?"
	if connectedName == "Delete":
		$"%Label".text = "Deleting..."
		$"%AddButton".text = "Delete 'em!"
	else:
		$"%Label".text = "Adding to " + connectedName + "..."
		$"%AddButton".text = "Add!"
	pass # Replace with function body.


func _on_AddButton_pressed():
	if connectedName == "Delete":
		rootProgram.a_bunch_deleted(amount)
		pass
	else:
		rootProgram.a_bunch_added(connectedName,amount)
	self.hide()
	pass # Replace with function body.
