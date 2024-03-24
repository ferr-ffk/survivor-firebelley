class_name WeightedTable
## A weighted table possui itens com pesos diferentes, e na hora de escolher um item aleatorio,
## os itens de maiores pesos têm uma maior chance de serem escolhidos

var soma_peso: int = 0
var items: Array[Dictionary] = []

func add_item(item, peso: int) -> void:
	items.append({"item": item, "peso": peso})
	soma_peso += peso


func pick_item() -> Variant:
	var peso_escolhido = randi_range(1, soma_peso)
	var soma_iteracao = 0
	
	for item in items:
		soma_iteracao += item["peso"]
		
		if peso_escolhido <= soma_iteracao:
			return item["item"]
	
	return items[0]
