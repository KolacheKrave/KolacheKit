extends ColorRect

var dir
var username = []
var output = []
# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_low_processor_usage_mode(true)
	randomize()
	
	dir = OS.get_user_data_dir() + "/"
	OS.execute("touch",[dir + "Kolache_List.txt",dir + "Timer_Presets.txt",dir + "Location_Presets.txt"])
	
	pass # Replace with function body.



func _on_StickersButton_pressed():
	get_tree().change_scene_to_file("res://LabelProgramParts/LabelProgram.tscn")
	pass # Replace with function body.


func _on_TimersButton_pressed():
	get_tree().change_scene_to_file("res://TimerProgramParts/TimerProgram.tscn")
	pass # Replace with function body.


func _on_quit_program_pressed():
	get_tree().quit()
	pass # Replace with function body.
