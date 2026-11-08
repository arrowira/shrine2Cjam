extends ColorRect



func _ready() -> void:
	change_radius(0.1)


@onready var mat: ShaderMaterial = material

func change_radius(r):
	mat.set_shader_parameter("radius", r)
	
