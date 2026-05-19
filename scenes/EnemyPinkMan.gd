extends CharacterBody2D

var Speed = 100.0
var Gravity = 980.0

func _ready():
	velocity.x = Speed
	$AnimatedSprite2D.play("Run")

func _physics_process(delta):
	velocity.y += Gravity
	flip()
	move_and_slide()

func _next_to_left_wall():
	return $Left.is_colliding()

func _next_to_right_wall():
	return $Right.is_colliding()

func flip():
	if _next_to_left_wall() or _next_to_right_wall():
		velocity.x *= -1
		$AnimatedSprite2D.scale.x *= -1
