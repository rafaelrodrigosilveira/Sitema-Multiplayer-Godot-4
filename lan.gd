extends Control



func _ready():
	Network.lista_alterada.connect(self.lista_alterada)
	pass


func _on_criar_pressed():
	Network.atualizar_nome($NomeEdit.text)
	Network.criar_servidor()
	pass 


func _on_conectar_pressed():
	Network.atualizar_ip($IPEdit.text)
	Network.atualizar_nome($NomeEdit.text)
	Network.entrar_servidor()
	pass 

func lista_alterada():
	var lista = Network.retornar_lista()
	$ListaJogadores.clear()
	for i in range(lista.size()):
		$ListaJogadores.add_item(lista[i][1])
		pass
	pass
