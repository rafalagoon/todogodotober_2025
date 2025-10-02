extends Control

var score:int = 100

func update_score (_score:int):
	score = _score
	$Score.text = "Score: "+str(score)


func game_over ():
	$GameOver.visible = true
	var text:String = "[rainbow][b]ULTRA PERFECT!!![/b][/rainbow]"
	
	if score >= 75 and score < 90:
		text = "[rainbow][b]Good Plumber!!![/b][/rainbow]"
	elif score >= 65:
		text = "[b]You are fast!\nAre you italian?[/b]"
	elif score >= 40:
		text = "[b]Not bad...[/b]"
	elif score >= 20:
		text = "[b]It could be worst[/b]"
	elif score > 0:
		text = "I hope you love [b]Sponge Bob[/b]"
	else:
		text = "[b]Gloo-gloo-gloo[/b]"
		
	$GameOver.text = text
