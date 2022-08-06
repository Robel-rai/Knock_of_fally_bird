extends Node2D

onready var hud = $HUD
onready var obstacle_spwaner = $ObsticalSpaner
onready var ground = $Ground

var score = 0 setget set_score

func _ready():
	obstacle_spwaner.connect("obstical_created", self, "_on_obsticle_created")
	new_game()

func new_game():
	self.score = 0
	obstacle_spwaner.start()

func player_score():
	self.score += 1 

func set_score(new_score):
	score = new_score
	hud.update_score(score)

func _on_obsticle_created(obs):
	obs.connect("score", self, "player_score")

func _on_DeathZone_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		if body.has_method("die"):
			body.die()


func _on_Player_died() -> void:
	game_over()

func game_over():
	obstacle_spwaner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("Obsticles", "set_physics_process", false ) 