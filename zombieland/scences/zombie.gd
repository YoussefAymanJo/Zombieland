extends CharacterBody3D

@export var speed = 5
@export var gravity = -9.8

func _ready() -> void:
	$holder/AnimationPlayer.play("mixamo_com")
func _physics_process(delta: float) -> void:
	velocity.y += gravity
	
	move_and_slide()
	
	pass


func _on_timer_timeout() -> void:
	pass # Replace with function body.
