extends Node2D

func _ready():
	Global.node_creation_parent = self

func _exit_tree():
	Global.node_creation_parent = null
	
