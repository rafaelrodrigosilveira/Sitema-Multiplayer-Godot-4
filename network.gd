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
	rpc("registrar_jogador", id, nome_jogador) # chamada remota para registrar jogador
	pass

func par_disconectado(id):
	pass

func falha_na_conexao():
	pass

func queda_do_servidor():
	pass

# REGISTRAR JOGADOR
@rpc("any_peer")
func registrar_jogador(id,nome):
	if multiplayer.is_server():
		# repassa aos clientes a lista de jogadores conectados
		for i in range(jogadores.size()):
			rpc_id(id, "registrar_jogador", jogadores[i][0],jogadores[i][1])
		# registra o novo jogador
		rpc("registrar_jogador",id,nome)
	# acrescenta os dados dos jogadores a lista
	jogadores.append([id,nome])
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
