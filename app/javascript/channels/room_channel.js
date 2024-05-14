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
  onPageLoad('groups#chat', function() {
    console.log("loaded.");
  
    const subscriptions = consumer.subscriptions.subscriptions;
    const userId = $('#messages').data('user_id');
    const userIdentifier = `"user_id":"${userId}"`;
  
    if (subscriptions) {
      subscriptions.map(function userUnsubscribe(subscription) {
        if (subscription.identifier.includes(userIdentifier)) {
          subscription.consumer.subscriptions.remove(subscription)
        };
      });
    };
  
    // ここから追加
    let already_connected = false
    for (let subscription of consumer.subscriptions.subscriptions) {
      let already_connected_room_id = JSON.parse(subscription.identifier).room_id;
      if (already_connected_room_id === room_id) {
        already_connected = true
        break
      }
    }
    // ここまで追加
  
    if (already_connected){
      return
    }
  
    // const chatChannelを追記
    const chatChannel = consumer.subscriptions.create({
      channel: 'RoomChannel', group: $('#messages').data('room_id'), user: userId  }, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log("connected.");
      },
  
      disconnected() {
        console.log("disconnected.");
      },
  
      // room_channel.rbでブロードキャストされたデータがreceivedに届き、アラート表示を実行。
      // アラート表示する内容は「data([‘message’])」
      // 「event.target.value」で取得したデータと同じ
      received(data) {
        console.log("recieved.");
        // Called when there's incoming data on the websocket for this channel
        const messages = document.getElementById('messages');
        messages.insertAdjacentHTML('beforeend', data['message']);
      },
  
      // 仮引数 function(message)のmessage
      // 実引数 event.target.value
      // room_channel.rbのspeakアクションを動かすために、speak関数を定義
      speak: function (message) {
        console.log("group_id:");
        console.log($('#messages').data('room_id'));
        return this.perform('speak', { message: message, group_id: $('#messages').data('room_id'), user_id: $('#messages').data('user_id')});
      }
    });
  
    // フォーム内でEnterキーが押された時の動作を記述
    window.document.onkeydown = function (event) {
      if (event.key !== 'Enter' || event.isComposing) {
        return
      }
      chatChannel.speak(event.target.value);
      event.target.value = '';
      event.preventDefault();
    };
  });

  onPageLoad('sessions#new', function() {
    // フォーム内でEnterキーが押された時の動作を記述
    window.document.onkeydown = function (event) {
      if (event.key == 'Enter') {
        console.log("push login button by press return key.");
        document.querySelector("#login-btn").click();
      }
    };
  });

  onPageLoad('notes#new', function() {
    $(".form-control").each(function(){ 
      var $textarea = $(this);
      var lineHeight = parseInt($textarea.css('line-height'));
      $textarea.on('input', function(e) {
        var lines = ($(this).val() + '\n').match(/\n/g).length;
        $(this).height(lineHeight * lines + 20);
      });
    });

    var $input_good = $('#note_good');
    // フォームに入力され、ポインターがテキストボックスから外れた時に発火するイベント
    $input_good.on('change', function(event) {
      console.log('Good Section has been entered. The value is: ', $input_good.val());
      fetch('/notes/post_api_request_good', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          // CSRFトークンをmetaタグから取得して設定
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({data: { value: $input_good.val() }}) // ここに必要なデータを設定
      })
      .then(response => response.json())
      .then(data => {
        console.log('Success:', data);
      })
      .catch((error) => {
        console.error('Error:', error);
      });
    });

    var $input_bad = $('#note_bad');
    // フォームに入力され、ポインターがテキストボックスから外れた時に発火するイベント
    $input_bad.on('change', function(event) {
      console.log('Bad Section has been entered. The value is: ', $input_bad.val());
      fetch('/notes/post_api_request_bad', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          // CSRFトークンをmetaタグから取得して設定
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({data: { value: $input_bad.val() }}) // ここに必要なデータを設定
      })
      .then(response => response.json())
      .then(data => {
        console.log('Success:', data);
      })
      .catch((error) => {
        console.error('Error:', error);
      });
    });

    var $input_next = $('#note_next');
    // フォームに入力され、ポインターがテキストボックスから外れた時に発火するイベント
    $input_next.on('change', function(event) {
      console.log('Next Section has been entered. The value is: ', $input_next.val());
      fetch('/notes/post_api_request_next', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          // CSRFトークンをmetaタグから取得して設定
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({data: { value: $input_next.val() }}) // ここに必要なデータを設定
      })
      .then(response => response.json())
      .then(data => {
        console.log('Success:', data);
      })
      .catch((error) => {
        console.error('Error:', error);
      });
    });
  });
};
