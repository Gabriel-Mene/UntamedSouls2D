extends Control

var next_scene = preload("res://scenes/interface/initial_screen.tscn")

onready var video_player: VideoPlayer = $VideoPlayer

func _ready():
	video_player.play()
	video_player.connect("finished", self, "_on_VideoPlayer_finished")

func _on_VideoPlayer_finished():
	get_tree().change_scene_to(next_scene)
