extends CollisionShape2D


func _on_respawn_point_body_entered(body):
	if body.is_in_group('Player'):
		body.respawnPoint = body.position
