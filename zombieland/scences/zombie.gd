extends CharacterBody3D

@export var speed = 10
@export var gravity = -10.00

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: CharacterBody3D = %Player

func _ready() -> void:
	$holder/AnimationPlayer.play("mixamo_com")
	make_path()

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	var dir = to_local(navigation_agent_3d.get_next_path_position()).normalized()
	$holder.look_at(player.position)

	velocity = dir * speed
	move_and_slide()

func make_path():
	navigation_agent_3d.target_position = player.global_position

func _on_timer_timeout() -> void:
	make_path()
	pass
