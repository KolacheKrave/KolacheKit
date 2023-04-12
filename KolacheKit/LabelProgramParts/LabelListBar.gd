extends Control
@onready var list = $"%LabelList"
@onready var listNabber = get_node("/root/LabelProgram")
var timerFired = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Clear_pressed():
	get_tree().call_group("label_buttons", "clear_pressed")
	$"%PrintButton".text = "Print"
	list.clear()


func delete_items(amount):
	var itemCount = list.get_item_count() - 1
	if itemCount == -1:
		return
	if list.is_anything_selected() == false:
		list.select(itemCount)
	for x in amount:
		var selected = list.get_selected_items()
		var deletedText = list.get_item_text(selected[0])
		get_tree().call_group("label_buttons", "delete_passer", deletedText)
		list.remove_item(selected[0])
		list.select(selected[0]-1)
		var leftOnList = list.get_item_count()
		if leftOnList == 0:
			$"%PrintButton".text = "Print"
		else:
			$"%PrintButton".text = "Print x" + str(leftOnList)
	list.ensure_current_is_visible()


func _on_SortButton_pressed():
	var buttonOrderList = listNabber.kolacheList
	var itemCount = list.get_item_count()
	var y = 0
	var itemListArray = Array([])
	for x in itemCount:
		itemListArray.append(list.get_item_text(y))
		y = y + 1
	list.clear()
	for x in buttonOrderList:
		if ":" in x:
			pass
		else:
			for z in itemListArray:
				if x==z:
					list.add_item(x)




func _on_Delete_button_down():
	timerFired = false
	$"%DelTimer".start()
	pass # Replace with function body.


func _on_Delete_button_up():
	if timerFired == false:
		delete_items(int(listNabber.indexNumber))
	$"%DelTimer".stop()
	pass # Replace with function body.


func _on_DelTimer_timeout():
	timerFired = true
	listNabber.open_add_a_bunch("Delete")
	pass # Replace with function body.
