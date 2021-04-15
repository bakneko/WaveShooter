extends Sprite

export(String) var player_variable_key
export(float) var player_variable_value

export(float) var power_up_cooldown = 3

func _on_HitBox_area_entered(area):
	if area.is_in_group("player"):
		area.get_parent().set(player_variable_key, player_variable_value)
		area.get_parent().get_node("PowerUpCoolDownTimer").wait_time = power_up_cooldown
		area.get_parent().get_node("PowerUpCoolDownTimer").start()
		area.get_parent().power_up_reset.append(name)
		# name = PowerUpReload
		queue_free()
	pass
