extends Node

const IPPADRAO = "127.0.0.1"
const PORTA = 6007
const MAXJOGADORES = 5

var ip = IPPADRAO
var id = 0
var nome_jogador = ""
var par = null
var jogadores =[]

func _ready():
	multiplayer.connected_to_server.connect(self.conectado_ao_servidor)
	multiplayer.connection_failed.connect(self.falha_na_conexao)
	multiplayer.server_disconnected.connect(self.queda_do_servidor)
	pass

func conectado_ao_servidor():
	pass

func par_disconectado(id):
	pass

func falha_na_conexao():
	pass

func queda_do_servidor():
	pass

# FUNCAO DE CRIACAO DO SERVIDOR
func criar_servidor():
	par = ENetMultiplayerPeer.new()
	par.create_server(PORTA, MAXJOGADORES)
	multiplayer.set_multiplayer_peer(par)
	par.peer_disconnected.connect(self.par_disconectado)
	pass

# FUNCAO DE CONEXAO DO CLIENTE AO SERVIDOR
func entrar_servidor():
	par = ENetMultiplayerPeer.new()
	par.create_client(ip, PORTA)
	multiplayer.set_multiplayer_peer(par)
	pass
