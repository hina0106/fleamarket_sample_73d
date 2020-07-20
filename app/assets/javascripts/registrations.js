$( function() {
  $('#postcode').jpostal({
    postcode : [
      '#postcode'
    ],
    address : {
      '#sending_destination_prefecture_code' : "%3", //都道府県が入力される
      '#address_city'                        : "%4%5", //市区町村と町域が入力される
      '#address_street'                      : "%6%7" //大口事務所の番地と名称が入力される
    }
  });
});