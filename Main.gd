extends Node2D

var cmd:LineEdit
var dir=Directory.new()
func _ready():
	cmd=get_node("vbox/cmd")
	pass
func _on_ItemList_item_selected(index):
	if index==0:
		cmd.text="git clone"
	if index==1:
		cmd.text="git clone -b "
	if index==2:
		cmd.text="git pull"
	if index==3:
		cmd.text="git push"
	if index==4:
		cmd.text="git rm --cached"
	if index==5:
		cmd.text="git gc"
	if index==6:
		cmd.text="git init"
func _on_openHelp_pressed():
	$PopupPanel.popup()
func _on_openCmd_pressed():
	OS.shell_open("cmd")
func _on_openDir_pressed():
	OS.shell_open("user://")
func _on_add_cmds_pressed():
	OS.alert("未开发")
	pass # Replace with function body.
func _on_openGitDoc_pressed():
	OS.shell_open("https://git-scm.com/docs")
	pass # Replace with function body.
func _on_switchWorkDir_pressed():
	dir.change_dir($vbox/hbox/work_path.text)
	print("切换到>"+$vbox/hbox/work_path.text)
	pass
func _on_execute_pressed():
	var i=OS.execute("CMD.exe",[cmd.text],false)
	print_debug("执行结果>",i)
