extends ItemList
#用来存每个数据的数组
var itemList_data_array=[]

var itemList_texts=[] #所有命令名称
var item_count=0
var file=File.new()
func _ready():
	item_count=get_item_count()
#添加新的指令
func _on_add_useful_cmd_add_cmd(var_cmd,cmd,cmd_help):
	add_item(var_cmd)
	item_count=get_item_count()
	var itemList_data={} #命令名称 命令 帮助用命令
	itemList_data["item_var"]=var_cmd
	itemList_data["item_cmd"]=cmd
	itemList_data["item_help"]=cmd_help
	print("添加指令>",cmd)
	print("添加帮助>",cmd_help)
	set_item_metadata(item_count-1,itemList_data)
	itemList_data_array.append(itemList_data)
func _on_save_all_cmd_pressed():
	file.open("user://gitTool.json",File.WRITE)
	for i in get_item_count():
		var meta_data=get_item_metadata(i)
		var meta_data_var_cmd=meta_data["item_var"]
		var meta_data_cmd=meta_data["item_cmd"]
		var meta_data_help=meta_data["item_help"]
		var json=to_json({"item_var":meta_data_var_cmd,"item_cmd":meta_data_cmd,"item_help":meta_data_help})
		file.store_line(json)
	file.close()
	pass 