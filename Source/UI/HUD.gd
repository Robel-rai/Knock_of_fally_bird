extends CanvasLayer

onready var score_la = $Score

func update_score(new_score):
	score_la.text = str(new_score)