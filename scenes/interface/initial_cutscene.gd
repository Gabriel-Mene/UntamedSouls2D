extends Control

var next_scene = preload("res://scenes/management/level0.tscn")

func _on_VideoPlayer_finished():
	get_tree().change_scene_to(next_scene)
