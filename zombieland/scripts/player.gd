extends CharacterBody3D


@export var SPEED = 8.0
@export var JUMP_VELOCITY = 4.5
@export var  gravity = -9.8
@export var sensitivity = 0.004
@onready var head: Node3D = $head
@onready var camera_3d: Camera3D = $head/Camera3D

@onready var weaponraycast: Node3D = $head/Camera3D/Weapon/RayCast3D
@onready var weapon_anima: AnimationPlayer = $head/Camera3D/Weapon/AnimationPlayer
var bullet_left = 50
var bullet = preload("res://scences/bullet.tscn")

var health = 3 

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _unhandled_input(event: InputEvent) -> void:
	if event is  InputEventMouseMotion : 
		head.rotate_y(-event.relative.x * sensitivity)
		camera_3d.rotate_x(-event.relative.y * sensitivity)
		camera_3d.rotation.x = clamp(camera_3d.rotation.x,deg_to_rad(-40),deg_to_rad(60))
func _physics_process(delta: float) -> void:
	if health == 0 :
		get_tree().reload_current_scene()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("shoot") and bullet_left  > 0 :
		if !weapon_anima.is_playing():
			weapon_anima.play("shoot")
			shoot()
	if Input.is_action_just_pressed("reload") : 
		weapon_anima.play("reload")
		bullet_left = 50
	$head/Camera3D/Label.text = str(bullet_left) + " / 50"
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func shoot():
	bullet_left -=1
	var bullet_inst = bullet.instantiate()
	bullet_inst.position  = weaponraycast.global_position
	bullet_inst.transform.basis  = weaponraycast.global_transform.basis
	get_parent().add_child(bullet_inst)
	pass

func kill():
	health -= 1
	pass
