extends Area2D

export var next_scene = ""

func _on_Portal_body_entered(body):
	if body.is_in_group("player"):
		var _change_scene: bool = get_tree().change_scene(next_scene)
		
