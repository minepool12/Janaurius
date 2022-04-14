extends Control
var dia=["Child of Fate, Your time has come. Let us see your fate in the world", 
"What the hell was that dream. It felt like i was really there"]
var dia_index=0
var finished = false
var namec=["????", "mc"]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialog()

func _process(delta):
	$"Tween/Next-indicator(1)".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
#Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func load_dialog():
	if dia_index < dia.size():
		finished=false
		$RichTextLabel.bbcode_text = dia[dia_index]
		$RichTextLabel2.bbcode_text = namec[dia_index]
		$RichTextLabel.percent_visible=0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		queue_free()
	dia_index+=1
	if dia_index==3:
		State.dialog=true
		Control1._ready()
		

func _on_Tween_tween_completed(object, key):
	finished=true # Replace with function body.
