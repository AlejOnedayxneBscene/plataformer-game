extends CharacterBody2D

var Speed = 100.0
var Gravity = 900
const JumpPower = -700
var nJumps = 1

func _ready():
	$AnimatedSprite2D.play("Idle")

func _physics_process(delta):

	velocity.y += Gravity * delta

	# DEBUG posición
	print("POS:", global_position)

	# Reiniciar saltos
	if is_on_floor():
		nJumps = 1

	# DEBUG raycast Right
	print("Right collision:", $Right.is_colliding())

	if $Right.is_colliding():
		print("Right detecta:", $Right.get_collider().name)

	# DEBUG raycast Near
	print("Near collision:", $Near.is_colliding())

	if $Near.is_colliding():
		print("Near detecta:", $Near.get_collider().name)

	# Movimiento
	if seePlayer():
		print("VE AL PLAYER")
		move()
	else:
		print("NO VE AL PLAYER")
		velocity.x = 0

	# Salto
	if nearPlayer():
		print("CERCA DEL PLAYER")
		jump()

	# Animaciones
	if is_on_floor():
		if velocity.x > 0:
			$AnimatedSprite2D.play("Run")
		else:
			$AnimatedSprite2D.play("Idle")

	move_and_slide()

	# DEBUG velocidad
	print("Velocity X:", velocity.x)
	print("-------------------")

func nearPlayer():
	return $Near.is_colliding()

func seePlayer():
	return $Right.is_colliding()

func move():
	velocity.x = Speed

func jump():
	if nJumps > 0:
		velocity.y = JumpPower
		nJumps -= 1
		$AnimatedSprite2D.play("Jump")
