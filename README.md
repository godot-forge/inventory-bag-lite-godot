# Inventory Bag Lite — Godot 4

Free Godot 4 addon for slot-based inventory — add/remove/stack items with save/load.

## Features (Lite — Free, max 10 slots)

- `add_item(id, qty, max_stack)` → returns added count
- `remove_item(id, qty)` → bool
- `has_item(id)` / `count(id)`
- `all_items()` / `slot_count()` / `is_full()`
- `clear()` / `save_state()` / `load_state()`
- Signals: `item_added`, `item_removed`, `inventory_full`

## Quick Start

```gdscript
# Autoload: Inventory
Inventory.add_item("potion", 5, 10)
Inventory.remove_item("potion", 2)
print(Inventory.count("potion"))  # 3
```

## Upgrade to PRO

[Inventory Bag PRO](https://godot-forge.itch.io/inventory-bag-pro-godot) adds:
- Unlimited slots
- Item categories filter
- Equip slots (main_hand, head, etc.)
- Hotbar with configurable size
- Sort by ID
- `item_equipped` / `item_unequipped` / `hotbar_changed` signals

---
Made with ♥ by [GodotForge](https://itch.io/profile/godot-forge)
