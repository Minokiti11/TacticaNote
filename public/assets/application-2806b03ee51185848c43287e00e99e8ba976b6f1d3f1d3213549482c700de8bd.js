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
// import "./modal.js"
import "./video_settings.js"

const player = videojs('video', {
    autoplay: false, // 自動再生を無効
    fluid: true, // 動画コンテンツを親要素いっぱいに広げる
    loop: false, // 繰り返し再生無効
    controls: true, // コントローラ表示
    playbackRates: [0.5, 1, 1.3, 1.5], // 再生速度の倍率
});
var video_el = document.getElementById("video");


video_el.addEventListener('timeupdate', function() {
	console.log(video_el.currentTime);
});

video_el.onloadedmetadata = function() {
    console.log('metadata loaded!');
    console.log(this.duration); //this refers to video_el

    // コントローラに10秒戻しボタンと10秒送りボタンを追加
    const rewindButton = player.getChild('ControlBar').addChild('button');
    const forwardButton = player.getChild('ControlBar').addChild('button');
    rewindButton.controlText('10秒戻し');
    forwardButton.controlText('10秒送り');

    // アイコンを設定
    player.getChild('ControlBar')
        .el()
        .insertBefore(
            rewindButton.el(),
            player.getChild('ControlBar').getChild('pictureInPictureToggle').el()
        )
        .innerHTML = `<img src='../assets/rewind.png' width=20 />`;

    player.getChild('ControlBar')
        .el()
        .insertBefore(
            forwardButton.el(),
            player.getChild('ControlBar').getChild('pictureInPictureToggle').el()
        )
        .innerHTML = `<img src='../assets/forward.png' width=20 />`;

    // スキップ処理を追加
    rewindButton.el().addEventListener('click', () => {
        this.currentTime -= 10;
    });
    forwardButton.el().addEventListener('click', () => {
        console.log("forward.");
        console.log("currentTime: ", this.currentTime);
        this.currentTime += 10;
    });
};
