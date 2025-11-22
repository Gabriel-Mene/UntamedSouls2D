extends EnemyTemplate

class_name BossMan

func _ready() -> void:
	randomize()
	drop_list = {
		"BossGun":[
			"res://assets/item/resource/glock17.png",
			100,
			"Resource",
			{},
			{}
		]
	}
		
		
	
