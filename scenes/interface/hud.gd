extends CanvasLayer

onready var inventory: Control = get_node("InventoryContainer")

func _ready():
	inventory.visible = false  # garante que começa fechado

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory()

func toggle_inventory() -> void:
	if inventory.visible:
		inventory.animation.play("hide_container")
		inventory.visible = false
	else:
		inventory.visible = true
		inventory.animation.play("show_container")
