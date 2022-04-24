
extends Control
signal textboxfalse
export(Resource) var enemy = null
var ptarget=0
# Declare member variables here. Examples:
# var a = 
# var b = "text"
var mccurrenthp=0
var currentenemyhp=0
var isdefend=false
var death=true;
# Called when the node enters the scene tree for the first time.
func _ready():
	if State.dialog==true:
		$AudioStreamPlayer.play()
		$"textbox".show()
		$emenycotainers.show()
		$"player Panel".show()
		$"CanvasLayer/action panel".show()
		set_hp($emenycotainers/ProgressBar, enemy.Hp, enemy.Hp)
		set_hp($"player Panel/playerdata/ProgressBar", State.currenthp, State.maxhp)
		$emenycotainers/TextureRect2.texture = enemy.texture
		$textbox.hide()
		#$"action panel".hide()
		$"CanvasLayer/action panel".hide()
		mccurrenthp=State.currenthp
		currentenemyhp=enemy.Hp
	
		display_text(" a wild %s has apeared" % enemy.name)
		yield(self, "textboxfalse")
		#$"action panel".show()
		$"CanvasLayer/action panel".show()
	else:
		#$CanvasLayer.get_child(0).hide()
		$"textbox".hide()
		$emenycotainers.hide()
		$"player Panel".hide()
		$AudioStreamPlayer.stop()
		
		#$"action panel".hide()
		$"CanvasLayer/action panel".hide()
	pass
func _input(event):
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		$textbox.hide()
		emit_signal("textboxfalse")

func set_hp(progress_bar, hp, maxhp):
	progress_bar.value=hp
	progress_bar.max_value =maxhp
	progress_bar.get_node("Label").text= "HP:%d/%d" % [hp, maxhp]

func display_text(text):
	$textbox.show();
	$textbox/Label.text=text

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_attack_button_pressed():
	$"CanvasLayer/action panel".hide()
	display_text("Mc swing his sword")
	yield(self, "textboxfalse")
	currentenemyhp= max(0, currentenemyhp - State.atk)
	set_hp($emenycotainers/ProgressBar, currentenemyhp, enemy.Hp)
		#$"CanvasLayer/action panel".hide()
	$enemydamage.play("enenydamaga")
	yield($enemydamage,"animation_finished")
	if(currentenemyhp==0):
		$enemydamage.play("death")
		yield($enemydamage, "animation_finished")
		State.dialog=false
		State.death=true
		#State.index=State.index+1
		
		_ready()
		get_tree().change_scene("res://src/test2.tscn")
		
		
	
	else:
		enemy_turn()
	
	


	if(Input.is_action_just_pressed("ui")==true):
		currentenemyhp= max(0, currentenemyhp - State.atk)
		set_hp($emenycotainers/ProgressBar, currentenemyhp, enemy.Hp)
		#$"CanvasLayer/action panel".hide()
		$enemydamage.play("enenydamaga")
		yield($enemydamage,"animation_finished")
	if(currentenemyhp==0):
		$enemydamage.play("death")
		yield($enemydamage, "animation_finished")
	else:
		enemy_turn()

		
	
func enemy_turn():
	$"CanvasLayer/action panel".hide()
	display_text("%s swing a might strike" %enemy.name)
	if(isdefend==true):
		isdefend=false
		mccurrenthp= max(0, mccurrenthp - (enemy.Att / 2))
		set_hp($"player Panel/playerdata/ProgressBar", mccurrenthp, State.maxhp)
		yield(self, "textboxfalse")
	else:
		mccurrenthp= max(0, mccurrenthp - enemy.Att)
		set_hp($"player Panel/playerdata/ProgressBar", mccurrenthp, State.maxhp)
		yield(self, "textboxfalse")
	$enemydamage.play("shake")
	yield($enemydamage,"animation_finished")
	if(mccurrenthp==0):
		display_text("Game Over")
		yield(self, "textboxfalse")
		get_tree().change_scene("res://src/Game_Over.tscn")
	else:
			$"CanvasLayer/action panel".show()


func _on_defend_button_pressed():
	isdefend=true
	$"CanvasLayer/action panel".hide()
	display_text("You raise your Sheild")
	yield(self, "textboxfalse")
	enemy_turn()


func _on_heal_button_pressed():
	$"CanvasLayer/action panel".hide()
	display_text("Mc heal himself ")
	yield(self, "textboxfalse")
	mccurrenthp= min(State.maxhp, mccurrenthp + 10)
	set_hp($"player Panel/playerdata/ProgressBar", mccurrenthp, State.maxhp)
	yield(get_tree().create_timer(0.5), "timeout")
	enemy_turn()
	
