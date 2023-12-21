# class_name Events
extends Node

signal select_garden_plot(garden_plot: GardenPlot)
signal select_fruit_tree(fruit_tree: FruitTree)
signal perform_action(action: Constants.ACTIONS)
signal set_actions(actions: Array[Constants.ACTIONS])
