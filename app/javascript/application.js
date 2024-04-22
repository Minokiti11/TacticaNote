// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import jquery from "jquery"
window.$ = jquery;

$(function(){
    console.log("Hello, jQuery.");
})
import "channels";
import "@rails/actioncable";
import "popper"
import "bootstrap"
import "./modal.js"
