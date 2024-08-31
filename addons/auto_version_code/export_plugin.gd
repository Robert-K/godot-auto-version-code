class_name AutoVersionCodeExportPlugin
extends EditorExportPlugin

const EXPORT_PRESETS_PATH := "res://export_presets.cfg"
const VERSION_CODE_KEY := "version/code"

var increment_queued := false

func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int):
	increment_queued = not is_debug

func _export_end():
	if increment_queued:
		var export_presets = ConfigFile.new()
		var error = export_presets.load(EXPORT_PRESETS_PATH)
		if error != OK:
			printerr("Error loading export presets at: ", EXPORT_PRESETS_PATH)
			return

		# Iterate over all sections.
		for section in export_presets.get_sections():
			if export_presets.has_section_key(section, VERSION_CODE_KEY):
				var version_code := export_presets.get_value(section, VERSION_CODE_KEY)
				version_code = int(version_code) + 1
				print("Incrementing [", section, "] ", VERSION_CODE_KEY, " to ", version_code)
				export_presets.set_value(section, VERSION_CODE_KEY, version_code)
				export_presets.save(EXPORT_PRESETS_PATH)