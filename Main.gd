extends Node2D
#用于在线提示的字符串
var git_help_cmd=""
var cmd:LineEdit
var dir=Directory.new()
var work_path:LineEdit
var itemList:ItemList
func _ready():
	cmd=get_node("vbox/cmd")
	itemList=get_node("ItemList")
	work_path=get_node("vbox/hbox/work_path")
#在选择时，设置数据
func setup_data_on_select(index):
	var meta_data=itemList.get_item_metadata(index)
	cmd.text=meta_data["item_cmd"]
	git_help_cmd=meta_data["item_help"]
	pass
#待重构 选中后 同步数据到右边编辑框内
func _on_ItemList_item_selected(index):
	setup_data_on_select(index)
	#复制命令到系统粘贴板
	OS.clipboard=cmd.text
	print(OS.clipboard+">已复制到粘贴板 请到cmd输入指令")
	print("当前指令>"+cmd.text)
	print("帮助指令>"+git_help_cmd)
	print("metaData>",itemList.get_item_metadata(index))
func _on_openHelp_pressed():
	$PopupPanel.popup()
func _on_openCmd_pressed():
# warning-ignore:unused_variable
	var error=OS.shell_open("cmd")
func _on_openDir_pressed():
	var path=ProjectSettings.globalize_path("user://")
	print(path)
	var shell_err=OS.shell_open(path)
	print(shell_err)
func _on_add_cmds_pressed():
	$add_useful_cmd.popup()
func _on_openGitDoc_pressed():
# warning-ignore:unused_variable
	var err=OS.shell_open("https://git-scm.com/docs")
	pass # Replace with function body.
func _on_switchWorkDir_pressed():
	dir.change_dir($vbox/hbox/work_path.text)
	print("切换到>"+$vbox/hbox/work_path.text)
	pass
func _on_execute_pressed():
#	OS.alert("此功能暂未实现")
	var output=[]
	var i=OS.execute("CMD.exe",["/C cd "+work_path.text+"&"+cmd.text],true,output)
	print_debug("执行结果>",output)
func _on_git_help_pressed():
	var out_put=Array()
# warning-ignore:unused_variable
	var err=OS.execute("CMD.exe", ["/C git help "+git_help_cmd], true,out_put)
	print(out_put)
func _on_remove_cmd_pressed():
	var items=itemList.get_selected_items()
	itemList.remove_item(items[0])
	print(items[0])
	pass # Replace with function body.
