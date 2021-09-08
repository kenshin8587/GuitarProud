import { $ } from "@rails/ujs";

$(function(){
  function buildHTML(message){
    var message_id = message.id;

    var message = message.content ? `${message.content}` : "";
    var date = message.date;
    var html = `
      <div class="messages__message__list" data-id="${message_id}">
      <p class="messages__message__list--date">${date}></p>
      <p class="messages__message__list--content">${content}></p>
      </div>
    `;
    return html;
  };

  $('#messages__new__form').on('submit', function(e){
    e.preventDefault();

    var formData = new FormData(this);
    var url = window.location.href;

    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'json',
      data: formData,
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.messages__message').append(html);
      $('form')[0].reset();
      $('#messages-btn').prop('disabled', false);
      var i = $('.messages__message__list:last').offset().top;
        $('html, body').animate({scrollTop:i});
    })
    .fail(function(){
      alert("メッセージの送信に失敗しました");
    });
  });

  var reloadMessages = function(){
    var last_message_id = $("messages__message__list:last").data("id");
    if (window.location.href.match(/\/rooms\/\d+\/messages/)){
      $.ajax({
        url: 'api/messages',
        type: 'GET',
        dataType: 'json',
        data: {id: last_message_id}
      })
      .done(function(messages){
        var insertHTML = '';
        messages.forEach(function(message){
          insertHTML = buildHTML(message);
          $('.messages__message').append(insertHTML);
        })
      }).fail(function(){
        alert('error');
      });
    };
  };
  setInterval(reloadMessages, 7000);
});