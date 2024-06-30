$(function(){
	console.log("hey, it's a modal.js");
	// 変数に要素を入れる
	var open = $('.modal-open'),
		close = $('.modal-close'),
		container = $('.modal-container');

	//開くボタンをクリックしたらモーダルを表示する
	open.on('click',function(){	
		container.addClass('active');
		return false;
	});

	//閉じるボタンをクリックしたらモーダルを閉じる
	close.on('click',function(){	
		container.removeClass('active');
	});

	//モーダルの外側をクリックしたらモーダルを閉じる
	$(document).on('click',function(e) {
		if(!$(e.target).closest('.modal-body').length) {
			container.removeClass('active');
		}
	});

    const videoIndex = $('#video-index');
    videoIndex.show();
	// トグルボタンの状態を監視
	$('#toggle').on('change', function() {
		if (this.checked) {
			videoIndex.show();
		} else {
			videoIndex.hide();
		}
	});
});
