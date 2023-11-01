extends Node

func between(min: float, max: float, num: float) -> bool:
	return min < num and num < max

func is_subset(complete: Array, to_check: Array) -> bool:
	for e in to_check:
		if not complete.has(e):
			return false

	return true
