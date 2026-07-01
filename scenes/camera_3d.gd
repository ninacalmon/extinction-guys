extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector3(0, 25, 25)
	look_at(Vector3(0, 0, 0))
