extends CollisionShape2D

func _on_body_entered(body):
	if body.is_in_group('Cat'):
		body.velocity = 0
