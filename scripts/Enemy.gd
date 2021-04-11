extends Sprite

var speed = 75

var velocity = Vector2()

var stun = false
var hp = 3

var blood_particles = preload("res://scenes/BloodParticles.tscn")

func _process(delta):
	if Global.player != null and !stun:
		# 表明Player存在
		velocity = global_position.direction_to(Global.player.global_position)
	elif stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
	global_position += velocity * speed * delta
	if hp <= 0:
		if Global.camera != null:
			Global.camera.screen_shake(50, 0.1)
		# add score
		Global.score += 10
		# instance node
		if Global.node_creation_parent != null:
			var blood_particles_instance = Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle()
		queue_free()
	pass


func _on_HitBox_area_entered(area):
	# 注意 stun == false, 防止在击退状态下再次“击退”
	if area.is_in_group("enemy_damager") and !stun:
		modulate = Color.white
		velocity = - velocity * 6
		hp -= 1
		stun = true
		$StunTimer.start()
		area.get_parent().queue_free()
	pass


func _on_StunTimer_timeout():
	modulate = Color("ff414e")
	stun = false
	pass
