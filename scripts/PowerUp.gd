extends Sprite2D

func _on_HitBox_area_entered(area):
	if area.is_in_group("player"):
		Global.power_up_count += 1
		queue_free()
	pass
