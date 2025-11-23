extends EnemyTemplate

class_name Lacaio


func _ready() -> void:
	randomize()
	drop_list = {
		"Heal Banana": [
			"res://assets/item/consumable/healingbanana.png",
			70,
			"Health",
			5, 
			5 
		],
		
		"Normal Banana": [
			"res://assets/item/consumable/Banana_2.png",
			30,
			"Resource",
			{},
			2
		]
	}
