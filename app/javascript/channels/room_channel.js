import consumer from "channels/consumer"


var isOnPage, regularize;

var onPageLoad = function(controller_and_actions, callback) {
  var conditions;
  conditions = regularize(controller_and_actions);
  if (!conditions) {
    console.error('[onPageLoad] Unexpected arguments!');
    return;
  }
  return conditions.forEach(function(a_controller_and_action) {
    var action, controller, ref;
    ref = a_controller_and_action.split('#'), controller = ref[0], action = ref[1];
    if (isOnPage(controller, action)) {
      return callback();
    }
  });
};

regularize = function(controller_and_actions) {
  if (typeof controller_and_actions === 'string') {
    return [controller_and_actions];
  } else if (Object.prototype.toString.call(controller_and_actions).includes('Array')) {
    return controller_and_actions;
  } else {
    return null;
  }
};

isOnPage = function(controller, action) {
  var selector;
  selector = "body[data-controller='" + controller + "']";
  if (action) {
    selector += "[data-action='" + action + "']";
  }
  return $(selector).length > 0;
};

window.onload = function() {
  // onPageLoad('groups#chat', function() {
  //   const subscriptions = consumer.subscriptions.subscriptions;
  //   const userId = $('#messages').data('user_id');
  //   const userIdentifier = `"user_id":"${userId}"`;
  
  //   if (subscriptions) {
  //     subscriptions.map(function userUnsubscribe(subscription) {
  //       if (subscription.identifier.includes(userIdentifier)) {
  //         subscription.consumer.subscriptions.remove(subscription)
  //       };
  //     });
  //   };
  
  //   let already_connected = false
  //   for (let subscription of consumer.subscriptions.subscriptions) {
  //     let already_connected_room_id = JSON.parse(subscription.identifier).room_id;
  //     if (already_connected_room_id === room_id) {
  //       already_connected = true
  //       break
  //     }
  //   }
  
  //   if (already_connected){
  //     return
  //   }
  
  //   // const chatChannelを追記
  //   const chatChannel = consumer.subscriptions.create({
  //     channel: 'RoomChannel', group: $('#messages').data('room_id'), user: userId  }, {
  //     connected() {
  //       // Called when the subscription is ready for use on the server
  //       console.log("connected.");
  //     },
  
  //     disconnected() {
  //       console.log("disconnected.");
  //     },
  
  //     // room_channel.rbでブロードキャストされたデータがreceivedに届き、アラート表示を実行。
  //     // アラート表示する内容は「data([‘message’])」
  //     // 「event.target.value」で取得したデータと同じ
  //     received(data) {
  //       console.log("recieved.");
  //       // Called when there's incoming data on the websocket for this channel
  //       const messages = document.getElementById('messages');
  //       messages.insertAdjacentHTML('beforeend', data['message']);
  //     },
  
  //     // 仮引数 function(message)のmessage
  //     // 実引数 event.target.value
  //     // room_channel.rbのspeakアクションを動かすために、speak関数を定義
  //     speak: function (message) {
  //       console.log("group_id:");
  //       console.log($('#messages').data('room_id'));
  //       return this.perform('speak', { message: message, group_id: $('#messages').data('room_id'), user_id: $('#messages').data('user_id')});
  //     }
  //   });
  
  //   // フォーム内でEnterキーが押された時の動作を記述
  //   window.document.onkeydown = function (event) {
  //     if (event.key !== 'Enter' || event.isComposing) {
  //       return
  //     }
  //     chatChannel.speak(event.target.value);
  //     event.target.value = '';
  //     event.preventDefault();
  //   };
  // });

  onPageLoad('sessions#new', function() {
    // フォーム内でEnterキーが押された時の動作を記述
    window.document.onkeydown = function (event) {
      if (event.key == 'Enter') {
        document.querySelector("#login-btn").click();
      }
    };
  });

  onPageLoad('notes#new', function() {
    const trixEditors = document.querySelectorAll('trix-editor');
    trixEditors.forEach(editor => {
      editor.addEventListener('trix-initialize', function() {
        const minHeight = 100; // エディタの最小の高さを設定
        editor.style.minHeight = `${minHeight}px`;
        
        // 初期化時に高さを設定
        editor.style.height = 'auto';
        editor.style.height = `${Math.max(editor.scrollHeight, minHeight)}px`;
        
        editor.addEventListener('trix-change', function() {
          editor.style.height = 'auto';
          editor.style.height = `${Math.max(editor.scrollHeight, minHeight)}px`;
          console.log(editor.scrollHeight);
        });
      });
    });
  });

  onPageLoad('notes#edit', function() {
    const trixEditors = document.querySelectorAll('trix-editor');
    trixEditors.forEach(editor => {
      editor.addEventListener('trix-initialize', function() {
        const minHeight = 100; // エディタの最小の高さを設定
        editor.style.minHeight = `${minHeight}px`;
        
        // 初期化時に高さを設定
        editor.style.height = 'auto';
        editor.style.height = `${Math.max(editor.scrollHeight, minHeight)}px`;
        
        editor.addEventListener('trix-change', function() {
          editor.style.height = 'auto';
          editor.style.height = `${Math.max(editor.scrollHeight, minHeight)}px`;
        });
      });
    });
  });

  onPageLoad('practices#new', function() {
    $(".form-control").each(function(){
      $(document).on("input", $(this), function(evt){
        var min_height = 35; //テキストエリアの最小の高さをお好みで設定
        $(evt.target).height(min_height); //一旦最小サイズにする
        $(evt.target).height(evt.target.scrollHeight - 10); //スクロールなしでテキストが収まる最小の高さに上書き
      });
    });
  });

  onPageLoad('practices#edit', function() {
    $(".form-control").each(function(){
      $(document).on("input", $(this), function(evt){
        var min_height = 35; //テキストエリアの最小の高さをお好みで設定
        $(evt.target).height(min_height); //一旦最小サイズにする
        $(evt.target).height(evt.target.scrollHeight - 10); //スクロールなしでテキストが収まる最小の高さに上書き
      });
    });
  });
};
