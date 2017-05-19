$(document).on('turbolinks:load', function () {

// メッセージ表示のHTMLを生成
  function buildHTML(message) {
    var html = `
        <p class="chat__user">${message.name}</p>
        <p class="chat__date">${message.date}</p>
        <p class="chat__content">${message.body}</p>`;
    return html;
  }

// メッセージ送信の非同期通信
  $('.js-form').on('submit', function(e) {
    e.preventDefault();
    var textField = $('.js-form__text-field');
    var message = textField.val();

    $.ajax({
      type: 'POST',
      url: './messages',
      data: {
        message: {
          body: message
        }
      },
      dataType: 'json'
    })

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
