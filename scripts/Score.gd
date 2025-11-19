extends Label

func _process(_delta):
	text = str(Global.score)
	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		modulate = Color("#ffffff64")
	pass


func _on_Area2D_area_exited(area):
	if area.is_in_group("player"):
		modulate = Color("#ffffffff")
	pass
