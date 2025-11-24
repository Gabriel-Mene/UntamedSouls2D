extends Control # Ou o tipo de nó raiz da sua cena

# Pré-carrega a próxima cena para a transição
var next_scene = preload("res://scenes/management/level0.tscn")

# 1. Referência ao nó VideoPlayer (ajuste o caminho se necessário)
onready var video_player: VideoPlayer = $VideoPlayer

func _ready():
	# 2. Quando a cena é carregada, inicie a reprodução do vídeo manualmente
	# Como você já desativou o Autoplay, esta linha é essencial para fazê-lo tocar.
	video_player.play()

# 3. Esta função é um sinal (signal) conectado.
# Ela é chamada automaticamente quando o vídeo termina.
func _on_VideoPlayer_finished():
	get_tree().change_scene_to(next_scene)
