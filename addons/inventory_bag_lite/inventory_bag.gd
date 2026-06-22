extends Node

const MAX_SLOTS := 10

signal item_added(item_id: String, quantity: int)
signal item_removed(item_id: String, quantity: int)
signal inventory_full()

# _slots: Array of {item_id, quantity, max_stack, data}
var _slots: Array = []

func add_item(item_id: String, quantity: int = 1, max_stack: int = 99, data: Dictionary = {}) -> int:
	if quantity <= 0:
		return 0
	var remaining: int = quantity
	# Stack onto existing slot
	for slot in _slots:
		if slot["item_id"] == item_id and slot["quantity"] < slot["max_stack"]:
			var space: int = slot["max_stack"] - slot["quantity"]
			var add: int = mini(remaining, space)
			slot["quantity"] += add
			remaining -= add
			emit_signal("item_added", item_id, add)
			if remaining == 0:
				return quantity
	# New slot
	while remaining > 0 and _slots.size() < MAX_SLOTS:
		var add: int = mini(remaining, max_stack)
		_slots.append({"item_id": item_id, "quantity": add, "max_stack": max_stack, "data": data.duplicate()})
		remaining -= add
		emit_signal("item_added", item_id, add)
	if remaining > 0:
		emit_signal("inventory_full")
	return quantity - remaining

func remove_item(item_id: String, quantity: int = 1) -> bool:
	if count(item_id) < quantity:
		return false
	var remaining: int = quantity
	var i: int = _slots.size() - 1
	while i >= 0 and remaining > 0:
		if _slots[i]["item_id"] == item_id:
			var take: int = mini(remaining, _slots[i]["quantity"])
			_slots[i]["quantity"] -= take
			remaining -= take
			emit_signal("item_removed", item_id, take)
			if _slots[i]["quantity"] == 0:
				_slots.remove_at(i)
		i -= 1
	return true

func has_item(item_id: String) -> bool:
	return count(item_id) > 0

func count(item_id: String) -> int:
	var total: int = 0
	for slot in _slots:
		if slot["item_id"] == item_id:
			total += slot["quantity"]
	return total

func is_full() -> bool:
	return _slots.size() >= MAX_SLOTS

func slot_count() -> int:
	return _slots.size()

func all_items() -> Array:
	var result: Array = []
	for slot in _slots:
		result.append(slot.duplicate())
	return result

func clear() -> void:
	_slots.clear()

func save_state() -> Array:
	var data: Array = []
	for slot in _slots:
		data.append(slot.duplicate())
	return data

func load_state(data: Array) -> void:
	_slots.clear()
	for slot in data:
		_slots.append(slot.duplicate())
