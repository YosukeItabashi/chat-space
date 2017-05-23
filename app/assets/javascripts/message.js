$(document).on('turbolinks:load', function () {

// メッセージ表示のHTMLを生成
  function buildHTML(message) {
    var image = (message.image !== null)
    ?(`<img src="${message.image}">`) : ('');

    var html = `
        <p class="chat__user">${message.name}</p>
        <p class="chat__date">${message.date}</p>
        <p class="chat__content">${message.body}</p>
        <p>${image}</p>`;
    return html;
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
      var pos = $('.chat').height();
      $('.chat').animate({
          scrollTop: $('.chat')[0].scrollHeight
      }, 'slow', 'swing');
    })
    .fail(function(data) {
      alert('メッセージを入力してください');
    });
  return false;
  });
});
