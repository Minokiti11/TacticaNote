// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import jquery from "jquery"
window.$ = jquery;

import "channels";
import "@rails/actioncable";
import "popper"
import "bootstrap"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
import "trix"
import "@rails/actiontext"

// Uppyのインポートと初期化
import { initializeUppy } from "./uppy_s3_multipart"
window.initializeUppy = initializeUppy;

// Uppyのスタイルシートを動的に追加
const uppyStyles = document.createElement('link');
uppyStyles.rel = 'stylesheet';
uppyStyles.href = 'https://releases.transloadit.com/uppy/v3.8.0/uppy.min.css';
document.head.appendChild(uppyStyles);

if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('/service-worker.js')
            .then(registration => {
            })
            .catch(error => {
            });
    });
}