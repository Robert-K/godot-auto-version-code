# ⬆️ Godot Auto Version Code

If you're building games for Google Play using the [Godot Game Engine](https://godotengine.org/), you'll need to increment the version code each time you upload a new APK.

This plugin will automatically increment the version code for you.

It works by registering an [Export Plugin](https://docs.godotengine.org/en/stable/classes/class_editorexportplugin.html). After each non-debug export, it will search the `export_presets.cfg` file for `version/code` keys and increment them by one.

It's super simple, so feel free to modify it to suit your needs.

[![forthebadge](https://forthebadge.com/images/featured/featured-uses-badges.svg)](https://forthebadge.com) [![forthebadge](https://forthebadge.com/images/featured/featured-made-with-crayons.svg)](https://forthebadge.com)