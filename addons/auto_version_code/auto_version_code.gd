@tool
extends EditorPlugin

var export_plugin: AutoVersionCodeExportPlugin

func _enter_tree():
	export_plugin = AutoVersionCodeExportPlugin.new()
	add_export_plugin(export_plugin)

func _exit_tree():
	remove_export_plugin(export_plugin)
