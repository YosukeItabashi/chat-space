$(document).on('turbolinks:load', function () {

// メッセージ表示のHTMLを生成
  function buildHTML(message) {
    var image = (message.image !== null)
    ?(`<img src="${message.image}">`) : ('');

    var html = `
      <div class="chat-wrapper" data-message-id="${message.id}">
        <p class="chat__user">${message.name}</p>
        <p class="chat__date">${message.date}</p>
        <p class="chat__content">${message.body}</p>
        <p>${image}</p>
      </div>`;
    return html;
  }

//登校後ページ下にスクロールする関数
  function scroll() {
    var pos = $('.chat').height();
    $('.chat').animate({
        scrollTop: $('.chat')[0].scrollHeight
    }, 'slow', 'swing');
  }

// メッセージ送信の非同期通信
  $('.js-form').on('submit', function(e) {
    e.preventDefault();
    var formdata = new FormData($(this).get(0));

    $.ajax({
      type: 'POST',
      url: './messages',
      data: formdata,
      dataType: 'json',
      processData: false,
      contentType: false
    })

// ajax通信→contoroller処理→以下のJSの処理

    .done(function(data) {
      var view = buildHTML(data);
      $('.chat').append(view);
      $('.js-form__text-field').val('');
      $("input").prop("disabled", false)
      scroll();
    })
    .fail(function(data) {
      alert('メッセージを入力してください');
    });
  return false;
  });

//メッセージの自動更新機能
 if (window.location.href.match(/messages/)) {
    setInterval(function() {
    $.ajax({
      type: 'GET',
      url: location.href,
      dataType: 'json'
    })

    .done(function(json) {
      var last_id = $('.chat-wrapper').last().data('message-id');
      var reload_view = '';
      json.messages.forEach(function(message) {
        if (message.id > last_id ) {
          reload_view = reload_view + buildHTML(message);
        }
      });
      $('.chat').append(reload_view);
      scroll();
    })

    .fail(function(json) {
      alert('自動更新に失敗しました');
    })
    } , 5000 );
  }
});
