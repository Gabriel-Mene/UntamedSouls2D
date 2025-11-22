extends Sprite
class_name PlayerTexture

signal game_over

var normal_attack: bool = false
var magic_attack: bool = false

var suffix: String = "_right"

export(NodePath) onready var attack_collision = get_node(attack_collision) as KinematicBody2D
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer
export(NodePath) onready var player = get_node(player) as KinematicBody2D


func animate(direction: Vector2) -> void:
	verify_position(direction)
	
	if player.on_hit or player.dead:
		hit_behavior()
	elif player.attacking or player.next_to_wall():
		action_behavior()
	elif direction.y != 0:
		vertical_behavior(direction)
	else:
		horizontal_behavior(direction)


func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
		suffix = "_right"
		player.direction = -1
		player.flipped = false
		position = Vector2.ZERO
		player.wall_ray.cast_to = Vector2(5.5, 0)
	elif direction.x < 0:
		flip_h = true
		suffix = "_left"
		player.direction = 1
		player.flipped = true
		position = Vector2(-2, 0)
		player.wall_ray.cast_to = Vector2(-7.5, 0)
		
func hit_behavior() -> void:
	player.set_physics_process(false)
	if player.dead:
		animation.play("dead")
	elif player.on_hit:
		animation.play("hit")
		
		
	
func action_behavior() -> void:
	if player.next_to_wall():
		animation.play("wall_slide")
	elif player.attacking and normal_attack:
		animation.play("attack" + suffix)
	elif player.attacking and magic_attack:
		animation.play("spell_attack")
		
		
func vertical_behavior(direction: Vector2) -> void:
	if direction.y > 0:
		player.landing = true
		animation.play("fall")
	elif direction.y < 0:
		animation.play("jump")




func horizontal_behavior(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("run")
	else:
		animation.play("idle")


func on_animation_finished(anim_name: String):
	match anim_name:
		"landing":
			player.landing = false
			player.set_physics_process(true)	
		
		"attack_left":
			normal_attack = false
			player.attacking = false
			
		"attack_right":
			normal_attack = false
			player.attacking = false
		
		"hit":
			player.on_hit = false
			player.set_physics_process(true)
			
		
		"dead":
			emit_signal("game_over")
			
		"spell_attack":
			magic_attack = false
			player.attacking = false
			
			
			
