extends Area3D
func _on_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://scences/main_menu.tscn")
	pass # Replace with function body.
