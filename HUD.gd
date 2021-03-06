extends CanvasLayer

signal play_again

var format_string = "%.1f"
var remaining_to_kill = 0

func _ready():
	new_game()

func new_game():
	$Control/StartScreen.visible = true
	$Control/GameOver.visible = false
	$Control/GameOver/WinMessage.visible = false
	$Control/GameOver/LoseMessage.visible = false
	$Control/GameScreen/RemainingToKill.text = str(get_node("/root/Main").remaining_to_kill) if get_node("/root/Main") else "15"
	$Control/GameScreen/Time.text = format_string % get_node("/root/Main").remaining_time if get_node("/root/Main") else "30"

func _on_Main_remaining_time_changed(remaining_time):
	var text = (format_string % remaining_time)
	$Control/GameScreen/Time.text = text

func _on_Main_score_changed(remaining):
	$Control/GameScreen/RemainingToKill.text = str(remaining)

func _on_Main_game_over(result):
	$Control/GameOver.visible = true
	$Control/GameScreen.visible = false
	if(result == 1):
		$Control/GameOver/WinMessage.visible = true
	elif(result == 0):
		$Control/GameOver/LoseMessage.visible = true

func _on_Main_game_start():
#	remaining_to_kill = remaining_to_kill
	$Control/StartScreen.visible = false
	$Control/GameScreen.visible = true

func _on_Main_remaining_to_kill_changed(remaining):
	remaining_to_kill = remaining
	$Control/GameScreen/RemainingToKill.text = str(remaining_to_kill)

func _on_PlayAgain_pressed():
	emit_signal("play_again")
	new_game()