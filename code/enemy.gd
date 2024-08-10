extends CharacterBody2D

var speed = 200
var direction = Vector2(1,0)
var possible_directions = [Vector2(1,0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]
var target_rotation = 0.0
var rotation_speed = 10.0
var bounce_back_speed = 0.0  # Speed to move back upon collision
var BOUNCE_BACK_TIME = 1  # Time to move back upon collision
var bounce_back_timer = 0.0  # Timer to track bounce back duration


func get_random_direction(direction):
	var new_d = direction
	while new_d == direction:
		new_d = possible_directions[randi() % possible_directions.size()]
	return new_d

func _physics_process(delta):
	if bounce_back_timer > 0:
		# Move back slowly
		bounce_back_timer -= delta
		var bounce_back_velocity = -direction * bounce_back_speed
		velocity = bounce_back_velocity
		if bounce_back_timer < 0.5 and bounce_back_timer > 0.0:
			direction = get_random_direction(direction)
			target_rotation = direction.angle()
			bounce_back_timer = -1
		move_and_slide()
	else:
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			# Start bounce back
			bounce_back_timer = BOUNCE_BACK_TIME
		else:
			move_and_slide()

	# Smoothly interpolate the rotation
	rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)



		
func hit():
	self.queue_free()
