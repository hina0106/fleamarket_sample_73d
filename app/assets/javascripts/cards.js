$(document).on('turbolinks:load', function(){
  if (!$('#regist_card')[0]) return false;

  Payjp.setPublicKey("pk_test_5cd49315ed1b34f0340edd67");
  Payjp.getPublicKey();

  $("#regist_card").on("click", function(e) {
    e.preventDefault();
    // 入力されたカード情報の値を取得
    var card = {
        number: $("#card_number_form").val(),
        exp_month: $("#exp_month_form").val(),
        exp_year: $("#exp_year_form").val(),
        cvc: $("#cvc_form").val()
    };

    // トークンを発行する(response.idがトークンになる)
    Payjp.createToken(card, function(status, response) {
      console.log(response.error);
      if (status === 200) {
        $("#card_number_form").removeAttr("name");
        $("#exp_month_form").removeAttr("name");
        $("#exp_year_form").removeAttr("name");
        $("#cvc_form").removeAttr("name");
        // トークンを格納
        var token = response.id;
        $("#card_token").append(`<input type="hidden" id="card_token" name="card_token" value=${token}>`)
        // コントローラー側に送信
        $(".card-form").get(0).submit();
      } else {
        alert("カード情報が正しくありません。");
        $("#regist_card").prop('disabled', false);
      }
    });
  });
});