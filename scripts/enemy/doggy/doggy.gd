extends EnemyTemplate

class_name Doggy


func _ready() -> void:
	randomize()
	drop_list = {
		"Heal Banana": [
			"res://assets/item/consumable/healingbanana.png",
			70, #chance
			"Health",
			5, #cura
			5#valor
		],
		
		"Normal Banana": [
			"res://assets/item/consumable/Banana_2.png",
			30,
			"Resource",
			{},
			2
		]
	}
