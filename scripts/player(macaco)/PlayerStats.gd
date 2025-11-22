extends Node

class_name PlayerStats


onready var invencibility_timer: Timer = get_node("InvencibilityTimer")
var shielding: bool = false

var base_health: int = 20
var base_attack: int = 5
var base_mana: int = 1000
var base_magic_attack: int = 50
var base_defense: int = 1

var bonus_health: int = 0
var bonus_mana: int = 0
var bonus_attack: int = 0
var bonus_magic_attack: int = 0
var bonus_defense: int = 0

var current_mana: int
var current_health: int 

var max_mana: int
var max_health: int

export(NodePath) onready var player = get_node(player) as KinematicBody2D
export(NodePath) onready var collision_area = get_node(collision_area) as Area2D
export(PackedScene) var floating_text


func _ready() -> void:
	current_mana = base_mana + bonus_mana
	max_mana = current_mana
	
	current_health = base_health + bonus_health
	max_health = current_health
	
	get_tree().call_group("bar_container", "init_bar", max_health, max_mana)


func update_health(type: String, value: int) -> void:
	match type:
		"Increase":
			current_health += value 
			spawn_floating_text("+", "Heal", value)
			if current_health >= max_health:
				current_health = max_health
			
		"Decrease":
			verify_shield(value)
			if current_health <= 0:
				player.dead = true #chamar animação de morte
			else:
				player.on_hit = true
				player.attacking = false #chamar a animação de tomar dano
				
	get_tree().call_group("bar_container", "update_bar", "HealthBar", current_health)
				
			
func verify_shield(value: int) -> void:
	if shielding:
		if (base_defense + bonus_defense) >= value:
			return
		var damage = abs((base_defense + bonus_defense) - value)
		spawn_floating_text("-", "Damage", damage)
		current_health -= damage
		
	else:
		spawn_floating_text("-", "Damage", value)
		current_health -= value
		
		
func update_mana(type: String, value: int) -> void:
	match type:
		"Increase":
			current_mana += value
			if current_mana >= max_mana:
				current_mana = max_mana
			
		"Decrease":
			current_mana -= value
		
	get_tree().call_group("bar_container", "update_bar", "ManaBar", current_mana)
	
	
func _process(_delta) -> void:
	#if Input.is_action_just_pressed("ui_select"):
	#	update_health("Decrease", 5)
	pass


func on_collision_area_entered(area):
	if area.name == "EnemyAttackArea":
		update_health("Decrease", area.damage) #dano do inimigo
		collision_area.set_deferred("monitoring", false)
		invencibility_timer.start(area.invencibility_timer) #varia de inimigo
		
		


func on_invencibility_timer_timeout():
	collision_area.set_deferred("monitoring", true)


func spawn_floating_text(type_sign: String, type: String, value: int) -> void:
	var text: FloatText = floating_text.instance()
	text.rect_global_position = player.global_position
	
	text.type = type 
	text.value = value
	text.type_sign = type_sign
	
	get_tree().root.call_deferred("add_child", text)

