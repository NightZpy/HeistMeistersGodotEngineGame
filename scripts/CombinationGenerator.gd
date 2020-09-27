extends Node

func generate():
	var length = (randi() % 4) + 4 
	return generate_with_fixed_length(length)


func generate_with_fixed_length(length):
	var combination = []
	
	for number in range(length):
		combination.append(randi() % 10)
		
	return combination