extends Control
var dia=["Child of Fate, Your time has come. Let us see your fate in the world", 
"That dream agian. Well too late to think about it. I going to be late for bracer test","Hey, you are so late. you missed out about what going on the test. It is 1vs1 match. I see you after the test","I better getting going to the testing area", " ","i did it"]
var dia_index=0
var finished = false
var namec=["????", "mc","cf", "mc"," ","mc"]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialog()
	$"a".play()

func _process(delta):
	$"Tween/Next-indicator(1)".visible = finished
	#$"Tween/Next-indicator(1)/AnimationPlayer".visible=finished
	if (Input.is_action_just_pressed("ui_accept") && State.dialog==false):
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
	#State.index+=1
	dia_index+=1
	if dia_index==5:
		$TextureRect.hide();
		$TextureRect.hide();
		State.dialog=true
		$"a".stop()
		Control1._ready()
		

func _on_Tween_tween_completed(object, key):
	finished=true # Replace with function body.
