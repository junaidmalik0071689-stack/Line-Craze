extends Node
class_name KeyManager

## Manages key collection and tracking for levels

var total_keys: int = 0
var collected_keys: int = 0

signal all_keys_collected
signal key_collected_update(collected: int, total: int)

func _ready() -> void:
	count_keys()

func count_keys() -> void:
	var keys = get_tree().get_nodes_in_group("keys")
	total_keys = keys.size()
	collected_keys = 0

func register_key_collected() -> void:
	collected_keys += 1
	key_collected_update.emit(collected_keys, total_keys)
	
	if collected_keys >= total_keys:
		all_keys_collected.emit()

func are_all_keys_collected() -> bool:
	return collected_keys >= total_keys

func get_keys_status() -> Dictionary:
	return {
		"collected": collected_keys,
		"total": total_keys
	}
