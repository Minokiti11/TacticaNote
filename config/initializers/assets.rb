# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join("public", "dist")

Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js modal.js controllers/application.js controllers/clipboard_controller.js controllers/diff_content_controller.js dist/videojs-zoom.js dist/videojs-zoom.css)