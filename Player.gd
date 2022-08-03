extends RigidBody2D

export var Flap_val = -200
onready var animation = $AnimationPlayer
var started = false
var MAX_ROTATION_DEGREES = -30.0

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("FLAP"):
		if started == false:
			start()
		flap()
	
	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES
	
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 3
		else:
			angular_velocity = 0

func start():
	if started: return
	started = true
	gravity_scale = 5.0
	animation.play("Flap")

func flap():
	linear_velocity.y = Flap_val
	angular_velocity = -8.0