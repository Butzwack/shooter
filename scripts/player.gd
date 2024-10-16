extends CharacterBody3D


const speed := 5.0
const jump_velocity := 4.5
var mouse_sensitivity := 0.0008
var hor_input := 0.0
var vert_input := 0.0
var is_sprinting := false
var sprint_speed_mod := 1.6
var speed_mod := 1.0
@onready var hor_pivot := self
@onready var vert_pivot := $VertPivot
@onready var weapon_attack = $WeaponAttack
var internal_res : int
var res_scale : String

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	internal_res = get_viewport().scaling_3d_scale * DisplayServer.screen_get_size().y as int
	res_scale = "%.2f" % (get_viewport().scaling_3d_scale)
	Global.debug.add_property("movement_speed", speed_mod * speed, 1)
	Global.debug.add_property("Resolution Scale", res_scale, 2)
	Global.debug.add_property("Internal Resolution", internal_res, 3)
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == 2:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hor_pivot.rotate_y(hor_input)
	vert_pivot.rotate_x(vert_input)
	vert_pivot.rotation.x = clamp(vert_pivot.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	if Input.is_action_pressed("sprint") && is_on_floor():
		is_sprinting = true
		speed_mod = sprint_speed_mod
	if Input.is_action_just_released("sprint"):
		is_sprinting = false
		speed_mod = 1
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (hor_pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed * speed_mod
		velocity.z = direction.z * speed * speed_mod
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	if not is_on_floor():
		velocity += get_gravity() * delta
	hor_input = 0
	vert_input = 0
	move_and_slide()

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			vert_input = - event.relative.y * mouse_sensitivity
			hor_input = - event.relative.x * mouse_sensitivity
	#if event is InputEventJoypadMotion:
		#if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#	vert_input = - event.axis_value * 1
		#	hor_input = - event.axis_value * mouse_sensitivity
	if Input.is_action_just_pressed("attack"):
		$VertPivot/WeaponRig/Weapon.attack()
		weapon_attack.play()
	
