extends ColorRect

#700x225

# Called when the node enters the scene tree for the first time.
func _ready():
#	if OS.get_name() == "Windows":
#		self.custom_minimum_size.x = 700
#		self.custom_minimum_size.y = 225
#		self.position.y = 500
#		$Sectioner.position.x = 510
#	else:
#	self.custom_minimum_size.x = 200
#	self.custom_minimum_size.y = 200
#	self.position.y = 0
#	$Sectioner.position.x = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func redraw(text, labelNum):
	if labelNum == 1:
		$Sectioner/Label1.text = text
	else:
		$Sectioner/Label2.text = text
	#await get_tree().idle_frame


func _draw():
	
	pass
