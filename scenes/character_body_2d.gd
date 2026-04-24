extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -550.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var saltos := 2
var coyote_active := false

# Cámara
var accum := 0
var itera := 0
const MAXIM = 10
const STEPS = 20

@onready var jump_label = $"../ui/Sprite2D/JumpLabel"
@onready var cam        = $Camera2D
@onready var sprite_2d  = $Sprite2D
@onready var timer      = $Timer
@onready var cam_timer  = $CamTimer

func _ready() -> void:
	jump_label.text = str(saltos)

func _physics_process(delta: float) -> void:
	# -------- GRAVEDAD --------
	if not is_on_floor():
		velocity.y += gravity * delta

	# -------- MOVIMIENTO HORIZONTAL --------
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * SPEED if direction != 0 \
			else move_toward(velocity.x, 0, SPEED)
	if direction != 0:
		sprite_2d.flip_h = direction < 0

	# -------- SNAPSHOT ANTES DE MOVE_AND_SLIDE --------
	var was_on_floor := is_on_floor()
	move_and_slide()

	# -------- COYOTE TIME --------
	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		coyote_active = true
		timer.start()

	if timer.time_left <= 0.0:
		coyote_active = false

	# -------- RESET AL ATERRIZAR --------
	if is_on_floor() and not was_on_floor:
		saltos = 2
		coyote_active = false
		timer.stop()
		jump_label.text = str(saltos)

	# -------- SALTO --------
	var can_jump := is_on_floor() or coyote_active or saltos > 0
	if Input.is_action_just_pressed("jump"):

	# SALTO NORMAL (suelo o coyote)
		if is_on_floor() or coyote_active:
			velocity.y = JUMP_VELOCITY
			coyote_active = false
			timer.stop()

		# DOBLE SALTO (en el aire)
		elif saltos > 0:
			velocity.y = JUMP_VELOCITY
			saltos -= 1

		# Actualizar UI
		jump_label.text = str(saltos)

	# -------- ZOOM --------
	if Input.is_action_just_pressed("zoomIn") and cam.zoom < Vector2(2, 2):
		cam.zoom += Vector2(0.5, 0.5)
	if Input.is_action_just_pressed("zoomOut") and cam.zoom > Vector2(0.5, 0.5):
		cam.zoom -= Vector2(0.5, 0.5)

	# -------- RECORRIDO CÁMARA --------
	if Input.is_action_just_pressed("Recorrido"):
		camera_move()

	# -------- ANIMACIONES --------
	update_animations(direction)

func update_animations(direction: float) -> void:
	if not is_on_floor():
		sprite_2d.play("Jump")
	elif direction != 0:
		sprite_2d.play("Run")
	else:
		sprite_2d.play("Idle")

func camera_move() -> void:
	accum = 0
	itera = 0
	cam.drag_horizontal_enabled = false
	cam_timer.start()

func _on_cam_timer_timeout() -> void:
	if itera <= MAXIM:
		accum -= STEPS
		cam.global_position = global_position + Vector2(accum, 0)
		itera += 1
	elif accum < 0:
		accum += STEPS
		cam.global_position = global_position + Vector2(accum, 0)
	else:
		cam_timer.stop()
		cam.global_position = global_position  # re-anchor to current player pos
		cam.drag_horizontal_enabled = true
