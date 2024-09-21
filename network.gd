extends Node

var scheme = "http"
var host = "127.0.0.1"
var port = 7350
var server_key = "defaultkey"

var session: NakamaSession
var client : NakamaClient = await Nakama.create_client(server_key, host, port, scheme)
var socket : NakamaSocket

func auth(email: String, password: String) -> String:
	var result = ""
	var newsession: NakamaSession = await client.authenticate_email_async(email, password)
	if not newsession.is_exception():
		session = newsession
	else:
		result = newsession.get_exception().message
	return result

func connect2():
	socket = Nakama.create_socket_from(client)
	var result = await socket.connect_async(session)
	if not result.is_exception():
		socket.connect("closed", onClosed)
		return OK
	return ERR_CANT_CONNECT

func onClosed():
	socket = null
