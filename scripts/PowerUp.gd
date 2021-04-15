extends Sprite

export(Dictionary) var variable_dictionary

export(float) var power_up_cooldown = 3

func _on_HitBox_area_entered(area):
	if area.is_in_group("player"):
		for variable in variable_dictionary:
			area.get_parent().set(variable, variable_dictionary[variable])
			area.get_parent().power_up_resets.append(variable)
		area.get_parent().get_node("PowerUpCoolDownTimer").wait_time = power_up_cooldown
		area.get_parent().get_node("PowerUpCoolDownTimer").start()
		# name = PowerUpReload
		queue_free()
	pass
