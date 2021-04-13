extends Label

func _process(_delta):
	text = str(Global.score)
	if Global.score >= Global.high_score and !Global.is_first_round:
		modulate = Color("ff414e")
	pass
