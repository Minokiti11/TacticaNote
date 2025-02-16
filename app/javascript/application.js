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


document.addEventListener("trix-paste", function(event) {
    // エディターの全てのspanタグをdivタグに置き換える
    const editorElement = event.target.editor.element;
    const spans = editorElement.querySelectorAll('span');
    spans.forEach(span => {
        const div = document.createElement('div');
        // 属性をコピー
        for (let attr of span.attributes) {
            div.setAttribute(attr.name, attr.value);
        }
        // 子要素を移動
        while (span.firstChild) {
            div.appendChild(span.firstChild);
        }
        // spanをdivに置き換える
        span.parentNode.replaceChild(div, span);
    });
});