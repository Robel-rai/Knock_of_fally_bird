extends Node2D

onready var hud = $HUD
onready var obstacle_spwaner = $ObsticalSpaner
onready var ground = $Ground
onready var menu_layer = $MenuLayer

const Save_FILE_Path = "user://savedata.save"

var score = 0 setget set_score
var highscore = 0

func _ready():
	obstacle_spwaner.connect("obstical_created", self, "_on_obsticle_created")
	load_high_score()

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
	
	if score > highscore: 
		highscore = score
		save_highscore()
		
	menu_layer.init_game_over_menu(score, highscore)

func _on_MenuLayer_start_game() -> void:
	new_game()

func save_highscore():
	var save_data = File.new()
	save_data.open(Save_FILE_Path, File.WRITE)
	save_data.store_var(highscore)
	save_data.close() 

func load_high_score():
	var save_data = File.new()
	if save_data.file_exists(Save_FILE_Path):
		save_data.open(Save_FILE_Path, File.READ)
		highscore = save_data.get_var()
		save_data.close()