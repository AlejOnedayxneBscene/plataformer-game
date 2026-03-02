extends CharacterBody2D

const SPEED = 300.0 # Bajamos un poco la velocidad para mejor control 
const JUMP_VELOCITY = -550.0

# Obtenemos la gravedad del proyecto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite_2d = $Sprite2D
@onready var timer = $Timer
func _physics_process(delta):
	# 1. Aplicar Gravedad 
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# IMPORTANTE: Reseteamos la velocidad en Y si está en el suelo 
		# para evitar que la gravedad se acumule
		velocity.y = 0 

	# 2. Manejar Salto 
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Movimiento Horizontal ↔️
	var direction = Input.get_axis("left", "right")
	
	if direction != 0:
		velocity.x = direction * SPEED
		sprite_2d.flip_h = (direction < 0) # Voltear el sprite según dirección
	else:
		# Frenamos usando SPEED para que se detenga en seco y no desaparezca
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Control de Animaciones 
	update_animations(direction)

	# 5. Ejecutar Movimiento
	var was_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_floor and not is_on_floor() and velocity.y>=0
	
	if just_left_ledge:
		timer.start()
	if Input.is_action_just_pressed("jump") and (is_on_floor() or timer.time_left>0.0):
			velocity.y = JUMP_VELOCITY
			timer.stop()
		

func update_animations(direction):
	if not is_on_floor():
		sprite_2d.play("Jump")
	elif direction != 0:
		sprite_2d.play("Run")
	else:
		sprite_2d.play("Idle")
