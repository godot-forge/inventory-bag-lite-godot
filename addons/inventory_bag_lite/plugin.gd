@tool
extends EditorPlugin

func _enable_plugin() -> void:
	add_autoload_singleton("Inventory", "res://addons/inventory_bag_lite/inventory_bag.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton("Inventory")
