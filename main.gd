extends Node

var email = ""
var password = ""
var network
var status
var login
var game

func _ready():
	network = $/root/Test/Network
	status = $/root/Test/Login/status
	login = $/root/Test/Login
	game = $/root/Test/Game
	game.hide()

func auth() -> String:
	var result = await network.auth(email, password)
	return result

func connect2():
	var result = await network.connect2()
	return result

func _on_login_button_button_up():
	var result = await auth()
	status.clear()
	if (result == ""):
		status.add_text("Success")
		var connectionresult = await connect2()
		if (connectionresult == 0):
			status.add_text("\nConnected")
			login.hide()
			game.show()
		else:
			status.add_text("Connection Failed")
	else:
		status.add_text("Failed: %s" % result)

func _on_email_input_text_changed(new_text: String) -> void:
	email = new_text

func _on_password_input_text_changed(new_text: String) -> void:
	password = new_text
