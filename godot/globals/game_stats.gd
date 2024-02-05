extends Node

## usare GameSettings.difficulty_mult come multiplicatore della difficolta, default 1
## ricordandosi di fare un ceil() per arrotondare
## oppure usare GameSettings.difficulty_setting per settare valori custom

## ex:
# boss_health = ceil(50 * GameSettings.difficulty_mult)
## or
# if GameSettings.difficulty_setting = "Hard":
#     boss_health = 75


func reset_stats() -> void: # da chiamare quando restarti il gioco
	#aggiungere qui le stats da resettare
	pass
