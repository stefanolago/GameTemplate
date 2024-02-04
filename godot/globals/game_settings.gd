extends Node

# per ora salvo qui i settings del gioco da salvare a dovremmo guardare meglio
# come metterli in un config o salvare i cookies 

var haptics_strenght: int = 1 # controller rumble , per ora solo 0 o 1
var difficulty_setting: String = "Medium":
	set(value):
		match value:   # sono valori default poi da settare a seconda del gioco
			"Story Mode":
				GameStats.difficulty_mult = 0.0
				print (GameStats.difficulty_mult)
			"Easy":
				GameStats.difficulty_mult = 0.5
				print (GameStats.difficulty_mult)
			"Medium":
				GameStats.difficulty_mult = 1.0
				print (GameStats.difficulty_mult)
			"Hard":
				GameStats.difficulty_mult = 1.5
				print (GameStats.difficulty_mult)
