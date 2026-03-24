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

	# 3. Movimiento Horizontal 
		
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
		
# Movimineto guia 1 parte 2		
#extends CharacterBody2D
#
#const SPEED = 400.0
#const JUMP_VELOCITY = -700.0
#@onready var sprite_2d = $Sprite2D
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#func _physics_process(delta):
	## Add run animation
	#if (velocity.x > 1 || velocity.x < -1):
		#sprite_2d.animation = "Run"
	#else:
		#sprite_2d.animation = "Idle"
#
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
		#sprite_2d.animation = "Jump"
#
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	#var direction = Input.get_axis("left", "right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, 10)
#
	#move_and_slide()
	#
	#var isLeft = velocity.x < 0
	#sprite_2d.flip_h = isLeft
