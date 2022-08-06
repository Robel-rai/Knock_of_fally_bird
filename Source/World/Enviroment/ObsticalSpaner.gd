extends Node2D

signal obstical_created(obs)

onready var timer = $Timer

var Obsiticle = preload("res://Source/World/Enviroment/Obsiticle.tscn")

func _ready():
	randomize()

func _on_Timer_timeout() -> void:
	spawn_obsticle()

func spawn_obsticle():
	var obsiticle = Obsiticle.instance()
	add_child(obsiticle)
	#Get a randome No from 150 - 550
	obsiticle.position.y = randi()%400 + 150
	emit_signal("obstical_created", obsiticle)

func start():
	timer.start()

func stop():
	timer.stop()

