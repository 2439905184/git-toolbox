extends Node2D
#用于在线提示的字符串
var git_help_cmd=""
var cmd:LineEdit
var dir=Directory.new()
var itemList:ItemList
func _ready():
	cmd=get_node("vbox/cmd")
	itemList=get_node("ItemList")
	for i in itemList.get_item_count():
		setup_meta_data(i)
#每一行meta data 同步
func setup_meta_data(index):
	var itemList_data={} #命令名称 命令 帮助用命令
	itemList_data["item_var"]=itemList.get_item_text(index)
	if index==0:
		itemList_data["item_cmd"]="git clone"
		itemList_data["item_help"]="clone"
	if index==1:
		itemList_data["item_cmd"]="git clone -b"
		itemList_data["item_help"]="clone"
	if index==2:
		itemList_data["item_cmd"]="git pull"
		itemList_data["item_help"]="pull"
	if index==3:
		itemList_data["item_cmd"]="git push"
		itemList_data["item_help"]="push"
	if index==4:
		itemList_data["item_cmd"]="git rm --cached"
		itemList_data["item_help"]="rm"
	if index==5:
		itemList_data["item_cmd"]="git gc"
		itemList_data["item_help"]="gc"
	if index==6:
		itemList_data["item_cmd"]="git init"
		itemList_data["item_help"]="init"
	if index==7:
		itemList_data["item_cmd"]="git commit --amend"
		itemList_data["item_help"]="commit"
	$ItemList.set_item_metadata(index,itemList_data)
#待重构
func _on_ItemList_item_selected(index):
	if index==0:
		cmd.text=itemList.get_item_metadata(index)["item_cmd"]
		git_help_cmd=itemList.get_item_metadata(index)["item_var"]
	if index==1:
		cmd.text="git clone -b "
		git_help_cmd="clone"
	if index==2:
		cmd.text="git pull"
		git_help_cmd="pull"
	if index==3:
		cmd.text="git push"
		git_help_cmd="push"
	if index==4:
		cmd.text="git rm --cached"
		git_help_cmd="rm"
	if index==5:
		cmd.text="git gc"
		git_help_cmd="gc"
	if index==6:
		cmd.text="git init"
		git_help_cmd="init"
	if index==7:
		cmd.text="git commit --amend"
		git_help_cmd="commit"
	if index>7:
		print("index>",index)
		cmd.text=itemList.get_item_metadata(index)["item_cmd"]
		git_help_cmd=itemList.get_item_metadata(index)["item_help"]
	#复制命令到系统粘贴板
	OS.clipboard=cmd.text
	print(OS.clipboard+">已复制到粘贴板 请到cmd输入指令")
	print("当前指令>"+cmd.text)
	print("帮助指令>"+git_help_cmd)
func _on_openHelp_pressed():
	$PopupPanel.popup()
func _on_openCmd_pressed():
	OS.shell_open("cmd")
func _on_openDir_pressed():
	var path=ProjectSettings.globalize_path("user://")
	print(path)
	var shell_err=OS.shell_open(path)
	print(shell_err)
func _on_add_cmds_pressed():
	$add_useful_cmd.popup()
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
func _on_git_help_pressed():
	var out_put=Array()
	OS.execute("CMD.exe", ["/C git help "+git_help_cmd], true,out_put)
	print(out_put)
func _on_remove_cmd_pressed():
	OS.alert("未完成")
	pass # Replace with function body.
