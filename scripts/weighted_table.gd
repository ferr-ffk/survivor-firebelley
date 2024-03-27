class_name WeightedTable
## A weighted table possui itens com pesos diferentes, e na hora de escolher um item aleatorio,
## os itens de maiores pesos têm uma maior chance de serem escolhidos

var soma_peso: int = 0
var items: Array[Dictionary] = []

func add_item(item, peso: int) -> void:
	items.append({"item": item, "peso": peso})
	soma_peso += peso


func remove(item: Variant) -> void:
	items = items.filter(func(item_atual):
		return item_atual["item"] != item
	)
	
	_atualizar_peso()


func pick_item(excluidos: Array = []) -> Variant:
	var items_ajustados: Array[Dictionary] = items
	var soma_items_ajustados = soma_peso
	
	# se há itens para excluir, filtra eles
	if excluidos.size() > 0:
		items_ajustados = []
		soma_items_ajustados = 0
		
		for item in items:
			var item_nao_existente: bool = not item["item"] in excluidos
			
			if item_nao_existente:
				items_ajustados.append(item)
				soma_items_ajustados += item["peso"]
				
			
	
	var peso_escolhido = randi_range(1, soma_items_ajustados)
	var soma_iteracao = 0
	
	for item in items_ajustados:
		soma_iteracao += item["peso"]
		
		if peso_escolhido <= soma_iteracao:
			return item["item"]
	
	return items[0]


func _atualizar_peso() -> void:
	soma_peso = 0
	
	for item in items:
		soma_peso += item["peso"]
