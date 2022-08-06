extends Node2D

signal score

const SPEED = 215

func _physics_process(delta: float):
	position.x += -SPEED * delta
	if global_position.x <= -200:
		queue_free()

func _on_Pipe_body_entered(body: PhysicsBody2D):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_ScoreArea_body_exited(body: PhysicsBody2D):
	if body is Player:
		emit_signal("score")
