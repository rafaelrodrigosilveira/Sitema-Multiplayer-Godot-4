extends Control



func _ready():
	Network.lista_alterada.connect(self.lista_alterada)
	pass


func _on_criar_pressed():
	Network.atualizar_nome($NomeEdit.text)
	Network.criar_servidor()
	$Criar.disabled = true # desabilita botão
	$Conectar.disabled = true # desabilita botão
	var ip = Network.retornar_ip()
	$IPServidor.text = "IP do Servidor: " + ip
	pass 


func _on_conectar_pressed():
	Network.atualizar_ip($IPEdit.text)
	Network.atualizar_nome($NomeEdit.text)
	Network.entrar_servidor()
	$Criar.disabled = true # desabilita botão
	$Conectar.disabled = true # desabilita botão
	pass 

func lista_alterada():
	var lista = Network.retornar_lista()
	$ListaJogadores.clear()
	for i in range(lista.size()):
		if lista[i][0] == Network.id:
			$ListaJogadores.add_item(lista[i][1] + str("(você)"))
		else:
			$ListaJogadores.add_item(lista[i][1])
	pass
