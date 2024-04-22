console.log("it's a video_settings.js");
const player = videojs('video', {
    autoplay: false, // 自動再生を無効
    fluid: true, // 動画コンテンツを親要素いっぱいに広げる
    loop: false, // 繰り返し再生無効
    controls: true, // コントローラ表示
    playbackRates: [0.5, 1, 1.3, 1.5], // 再生速度の倍率
});
var video = document.getElementById("video");

video.onloadedmetadata = (event) => {
    console.log("loaded metadata.");
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
        video.currentTime -= 10;
    });
    forwardButton.el().addEventListener('click', () => {
        console.log("forward.");
        console.log("currentTime: ", video.currentTime);
        video.currentTime += 10;
    });
};
