extends Node

# Configurações
var shake_intensity: float = 0.0
var shake_decay: float = 5.0
var noise: FastNoiseLite
var time: float = 0.0

func _ready():
	noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.frequency = 2.0

func _process(delta):
	if shake_intensity <= 0:
		return
	
	# Diminui a intensidade
	shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	
	# Aplica o wiggle
	apply_wiggle(delta)

func apply_wiggle(delta):
	var camera = get_viewport().get_camera_2d()
	if not camera:
		return
	
	time += delta * 20.0
	
	# Gera movimento tipo "wiggle" (mais natural que noise puro)
	var offset_x = sin(time * 1.3) * cos(time * 0.7) * 20.0 * shake_intensity
	var offset_y = cos(time * 1.1) * sin(time * 0.9) * 20.0 * shake_intensity
	
	camera.offset = Vector2(offset_x, offset_y)

func wiggle(intensity: float = 0.5):
	
	shake_intensity = min(shake_intensity + intensity, 1.0)

func stop():
	
	shake_intensity = 0
	var camera = get_viewport().get_camera_2d()
	if camera:
		camera.offset = Vector2.ZERO
