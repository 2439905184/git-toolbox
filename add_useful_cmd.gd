extends PopupPanel
signal add_cmd
func _on_btn_add_cmd_pressed():
	var var_cmd=$vbox/var_cmd.text
	var cmd=$vbox/cmd.text
	var cmd_help=$vbox/cmd_help.text
	emit_signal("add_cmd",var_cmd,cmd,cmd_help)
