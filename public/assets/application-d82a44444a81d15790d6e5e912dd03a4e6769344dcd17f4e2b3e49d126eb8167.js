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


document.addEventListener("trix-before-initialize", () => {
    console.log("passed.");
    Trix.config.blockAttributes.highlightSpan = {
        tagName: 'span',
        htmlAttributes: [ "class" ],
        inheritable: true,
    };
})

document.addEventListener("trix-paste", function(event) {
    // ペーストされた内容をHTML形式で取得
    const clipboardData = event.clipboardData || window.clipboardData;
    console.log(getPastedHTMLUsingHiddenElement(event));
    const html = clipboardData.getData("text/html");

    if (html) {
        // <span>タグを<div>タグに置き換え
        const modifiedHtml = html.replace(/<span\b([^>]*)>/gi, "<div$1>").replace(/<\/span>/gi, "</div>");

        // 既存のペースト動作をキャンセルし、加工したHTMLを挿入
        event.preventDefault();
        event.target.editor.insertHTML(modifiedHtml);
    } else {
        // HTMLデータがない場合はプレーンテキストとしてペースト
        const text = clipboardData.getData("text/plain");
        event.preventDefault();
        event.target.editor.insertString(text);
    }
});
