extends ItemList
#用来存每个数据的数组
var itemList_data_array=[]

var itemList_texts=[] #所有命令名称
var item_count=0
var file=File.new()
func _ready():
	item_count=get_item_count()
	file.open("user://gitTool.json",File.READ)
	#如果存在保存的配置文件，加载它
	if file.file_exists("user://gitTool.json"):
		var index=0
		#清空并从配置文件加载
		clear()
		#更换循环方式
		while file.get_position()<file.get_len():
			var line=file.get_line()
			print(line)
			var json_obj=parse_json(line)
			add_item(json_obj.item_var)
			set_item_metadata(index,json_obj)
			index+=1
	else:
		print("文件不存在，载入默认配置")
		file.open("res://config/gitTool.json",file.READ)
		for i in get_item_count():
			var line=file.get_line()
			var obj=parse_json(line)
			set_item_metadata(i,obj)
		file.close()
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
func _on_reset_config_pressed():
	var dir=Directory.new()
	dir.open("user://")
	var err=dir.remove("user://gitTool.json")
	if err==OK:
		OS.alert("重置完成")
	else:
		OS.alert("重置失败>问题码:"+str(err))
		OS.alert("请联系作者")
	pass
