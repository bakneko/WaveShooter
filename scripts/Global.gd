extends Node

# 修复如果没有Parent的问题
var node_creation_parent = null
var player = null
var camera = null
var score = 0
var high_score = 0
var is_first_round = true

# 全局的实例化子场景代码
func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
