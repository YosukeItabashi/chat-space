$(function() {

// ユーザー検索時に表示されるユーザー名と追加ボタンのHTML
  function appendList(user) {
    var html =
      `<div class="chat-group-user clearfix">
        <p class="chat-group-user__name">
          ${user.name}</p>
        <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加
        </a>
      </div>`;
    $('#user-search-result').append(html)
  }

// 追加ボタンクリック後のユーザー名と削除ボタンのHTML
  function buildMemberHTML(id, name) {
    var html =
    `<div class="chat-group-user clearfix" id=chat-group-user-${id}>
      <input type="hidden" name="group[user_ids][]" value="${id}">
      <p class="chat-group-user__name">${name}</p>
      <a class="user-search-remove chat-group-user__btn chat-group-user__btn--remove" data-user-id="${id}">削除</a>
    </div>`;
    return html
  }

// フォームに入力した瞬間に発動。コントローラーにjson形式で入力内容を送る。
  $(document).on('keyup', '.chat-group-form__input', function(e){
    e.preventDefault();
    var input = $.trim($(this).val());
    $.ajax({
      type: 'GET',
      url: '/users/search',
      data: ('keyword=' + input),
      processData: false,
      contentType: false,
      dataType: 'json'
    })

//コントローラーからデータが無事に戻ってきたら発動。ユーザーリストを作成する。dataにはコントローラの@usersが入っている。
    .done(function(data){
      $('#user-search-result').find('.chat-group-user').remove();
      $(data.members).each(function(i, user){
        appendList(user)
      });
    });
  });

//追加ボタンをクリックしたら発動。
  $(document).on('turbolinks:load', function(){
    $("#user-search-result").on('click', '.chat-group-user__btn--add', function(){
      var $chatGroupUserBtnAdd = $('.chat-group-user__btn--add');
      var id = $chatGroupUserBtnAdd.data('userId');
      var name = $chatGroupUserBtnAdd.data('userName');
      var insertHTML = buildMemberHTML(id, name);
      $('#chat-group-users').append(insertHTML);
      $chatGroupUserBtnAdd.parent('.chat-group-user').remove();
    });
  });

// 削除ボタンをクリックしたら発動。
  $('#chat-group-users').on('click', '.user-search-remove', function() {
    var id = $(this).data('userId');
    $(`#chat-group-user-${id}`).remove();
  })
});
