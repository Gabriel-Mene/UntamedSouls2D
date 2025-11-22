extends AnimatedSprite

class_name EffecttTemplate

func play_effect() -> void:
	play()


func on_animation_finished() -> void:
	queue_free()
