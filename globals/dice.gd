extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func roll_d20():
	return rng.randi_range(1, 20)

func roll_d6():
	return rng.randi_range(1, 6)

func roll_d100(tag = ""):
	var r = rng.randi_range(1, 100)
	if tag != "":
		print("'%s': %s" % [tag, r]) 
	return r

"""return random number between 1 and n (inclusive)"""
func roll_dn(n):
	return rng.randi_range(1, n)

func roll_d_range(from : int, to : int, inclusive = false):
	var i = 1 if inclusive else 0
	return rng.randi_range(from, to + i)

func roll(parameters):
	var parts = parameters.split('+')
	var dice = parts[0].split('d')
	var number = int(dice[0])
	var sides = int(dice[1])
	var modifier = int(parts[1])
	var base = modifier
	for i in number:
		base += roll_dn(sides)
	return base

func roll_variance(amount: int, coefficient = 40):
	var variance = rng.randf_range(-coefficient, coefficient)
	var percentage = variance / 100
	var raw_modifier = amount * percentage
	var modifier = int(raw_modifier)
	return amount + modifier
