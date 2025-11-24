extends KinematicBody2D

class_name Player


onready var player_sprite: Sprite = get_node("Texture")
onready var wall_ray: RayCast2D = get_node("WallRay")
onready var stats: Node = get_node("Stats")


var velocity: Vector2  #(150, 150)
var direction: int = 1
var jump_count: int = 0
var on_hit: bool = false
var dead: bool = false
var attacking: bool = false
var landing: bool = false
var on_wall: bool = false
var not_on_wall: bool = true
var can_track_input: bool = true
var flipped: bool = false


export(int) var speed 
export(int) var jump_speed
export(int) var player_gravity
export(int) var wall_jump_speed
export(int) var wall_gravity
export(int) var wall_impulse_speed
export(int) var magic_attack_cost

func _physics_process(delta: float): 
	if velocity.x > 0:
		wall_ray.position.x = 8
	elif velocity.x < 0:
		wall_ray.position.x = -8
	horizontal_movement_env()
	vertical_movement_env()
	actions_env()
	
	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	player_sprite.animate(velocity)

func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")	
	velocity.x = input_direction * speed

	
func vertical_movement_env() -> void:
	if is_on_floor() or is_on_wall():
		jump_count = 0
		
	if Input.is_action_just_pressed("ui_up") and jump_count < 2: #espaço
		jump_count += 1
		spawn_effect("res://scenes/effect/dust/jump.tscn", Vector2(0, 18), flipped)
		if next_to_wall() and not is_on_floor():
			velocity.y = wall_jump_speed
			velocity.x += wall_impulse_speed * direction
		else:
			velocity.y = jump_speed 
		
		
func actions_env() -> void:
	attack()
	
	
	
func attack() -> void:
	var attack_condition: bool = not attacking
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		attacking = true
		player_sprite.normal_attack = true
	#elif Input.is_action_just_pressed("magic_attack") and attack_condition and stats.current_mana >= magic_attack_cost:
		#attacking = true
		#player_sprite.magic_attack = true
		#stats.update_mana("Decrease", magic_attack_cost)

func gravity(delta: float) -> void:
	if next_to_wall():
		velocity.y += wall_gravity * delta
		if velocity.y >= wall_gravity:
			velocity = wall_gravity
	else:
		velocity.y += delta * player_gravity
		if velocity.y >= player_gravity:
			velocity.y = player_gravity
		
func next_to_wall() -> bool:
	if wall_ray.is_colliding() and not is_on_floor():
		if not_on_wall:
			velocity.y = 0
			not_on_wall = false
			
		return true
	else:
		not_on_wall = true
		return false
		
func spawn_effect(effect_path: String, offset: Vector2, is_flipped: bool) -> void:
	var effect_instance: EffecttTemplate = load(effect_path).instance()
	get_tree().root.call_deferred("add_child", effect_instance)
	if is_flipped:
		effect_instance.flip_h = true
	
	effect_instance.global_position = global_position + offset
	
	effect_instance.play_effect()
	
func _exit_tree() -> void:
	if dead == true:
		return
	
	#data_management.data_dictionary.player_position = global_position
	#data_management.save_data()
	
