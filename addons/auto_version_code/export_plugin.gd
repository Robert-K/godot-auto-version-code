class_name AutoVersionCodeExportPlugin
extends EditorExportPlugin

const EXPORT_PRESETS_PATH := "res://export_presets.cfg"
const VERSION_CODE_KEY := "version/code"

var version_code: int = 0
var increment_queued: bool = false

func _get_name():
	return "Auto Version Code"

func _supports_platform(platform: EditorExportPlatform) -> bool:
	return true

func _get_export_options_overrides(platform: EditorExportPlatform) -> Dictionary:
	if not find_version_code(): return {}
	print("Overriding ", VERSION_CODE_KEY,": ", version_code)
	return {VERSION_CODE_KEY: version_code}

func load_export_presets():
	var export_presets = ConfigFile.new()
	var error = export_presets.load(EXPORT_PRESETS_PATH)
	if error != OK:
		printerr("Error loading export presets at: ", EXPORT_PRESETS_PATH)
		return null
	return export_presets

func find_version_code():
	var export_presets = load_export_presets()
	if export_presets == null: return false
	for section in export_presets.get_sections():
		if export_presets.has_section_key(section, VERSION_CODE_KEY):
			version_code = int(export_presets.get_value(section, VERSION_CODE_KEY))
			return true

	printerr("No ", VERSION_CODE_KEY," found in export presets at: ", EXPORT_PRESETS_PATH)
	return false

func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int):
	increment_queued = not is_debug

func _export_end():
	if increment_queued:
		version_code += 1
		var export_presets = load_export_presets()
		if export_presets == null: return
		for section in export_presets.get_sections():
			if export_presets.has_section_key(section, VERSION_CODE_KEY):
				print("Setting [", section, "] ", VERSION_CODE_KEY, " to ", version_code)
				export_presets.set_value(section, VERSION_CODE_KEY, version_code)
		export_presets.save(EXPORT_PRESETS_PATH)