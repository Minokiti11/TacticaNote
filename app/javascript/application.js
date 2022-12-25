// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import "controllers"

require("@rails/ujs").start()

Rails.start()