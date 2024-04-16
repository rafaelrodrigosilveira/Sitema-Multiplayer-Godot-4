extends Node

const IPPADRAO = "127.0.0.1"
const PORTA = 6007
const MAXJOGADORES = 5

var ip = IPPADRAO
var id = 0
var nome_jogador = ""
var par = null
var jogadores =[]

signal lista_alterada

func _ready():
	multiplayer.connected_to_server.connect(self.conectado_ao_servidor)
	multiplayer.connection_failed.connect(self.falha_na_conexao)
	multiplayer.server_disconnected.connect(self.queda_do_servidor)
	pass

func conectado_ao_servidor():
	id = multiplayer.multiplayer_peer.get_unique_id() # recebe id unico
	rpc("registrar_jogador", id, nome_jogador) # chamada remota para registrar jogador
	pass

@warning_ignore("unused_parameter", "shadowed_variable")
func par_disconectado(id):
	pass

func falha_na_conexao():
	pass

func queda_do_servidor():
	pass

# REGISTRAR JOGADOR
@rpc("any_peer")
@warning_ignore("shadowed_variable")
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
	id = multiplayer.multiplayer_peer.get_unique_id() # recebe id unico
	registrar_jogador(id, nome_jogador)
	emit_signal("lista_alterada")
	pass

# FUNCAO DE CONEXAO DO CLIENTE AO SERVIDOR
func entrar_servidor():
	par = ENetMultiplayerPeer.new()
	par.create_client(ip, PORTA)
	multiplayer.set_multiplayer_peer(par)
	pass

func atualizar_ip(novo_ip):
	ip = novo_ip
	pass

func atualizar_nome(novo_nome):
	nome_jogador = novo_nome
	pass

func retornar_lista():
	return jogadores
