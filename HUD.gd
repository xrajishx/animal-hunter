extends CanvasLayer

var time_remaining = 1.0
var format_string = "%.1f"
var remaining_to_kill = 0

func _ready():
	$Control/GameOver.visible = false
	$Control/GameOver/WinMessage.visible = false
	$Control/GameOver/LoseMessage.visible = false
	$Control/GameScreen.visible = false
	$Control/GameScreen/RemainingToKill.text = str(get_parent().remaining_to_kill)

func _on_Main_remaining_time_changed(remaining_time):
	var text = (format_string % remaining_time)
	$Control/GameScreen/Time.text = text

func _on_Main_score_changed(remaining):
	$Control/GameScreen/RemainingToKill.text = str(remaining)

func _on_Main_game_over(result):
	$Control/GameOver.visible = true
	if(result == 1):
		$Control/GameOver/WinMessage.visible = true
	elif(result == 0):
		$Control/GameOver/LoseMessage.visible = true

func _on_Main_game_start(remaining_to_kill, remaining_time):
	remaining_to_kill = remaining_to_kill
	$Control/StartScreen.visible = false
	$Control/GameScreen.visible = true

func _on_Main_remaining_to_kill_changed(remaining):
	remaining_to_kill = remaining
	$Control/GameScreen/RemainingToKill.text = str(remaining_to_kill)
