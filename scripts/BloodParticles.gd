extends CPUParticles2D

func _on_FreezeBloodTimer_timeout():
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	# 完全禁止粒子
	$AnimationPlayer.play("disapper")
	pass

