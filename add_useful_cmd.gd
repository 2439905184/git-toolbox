extends PopupPanel
signal add_cmd
func _on_btn_add_cmd_pressed():
	var var_cmd=$vbox/var_cmd.text
	var cmd=$vbox/cmd.text
	var cmd_help=$vbox/cmd_help.text
	if var_cmd!="" and cmd!="" and cmd_help!="":
		emit_signal("add_cmd",var_cmd,cmd,cmd_help)
	else:
		OS.alert("错误，你还有信息没有填写")
