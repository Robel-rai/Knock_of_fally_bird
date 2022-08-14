extends CanvasLayer

signal start_game

onready var start_massage = $StartMenu/StartMassage
onready var animation = $AnimationPlayer
onready var score_la = $GameOver/VBoxContainer/Score_lable
onready var hi_score_la = $GameOver/VBoxContainer/HighScore_lable
onready var game_over_menu = $GameOver

var game_started = false

func _input(event):
	if event.is_action_pressed("FLAP") && !game_started:
		emit_signal("start_game")
		animation.play("Player screen")
		game_started = true

func init_game_over_menu(score, highscore):
	score_la.text = "Score: " + str(score)
	hi_score_la.text = "BEST: " + str(highscore)
	game_over_menu.visible = true 

func _on_Restart_pressed() -> void:
	get_tree().reload_current_scene()
