$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<label id="image-input__label">
                    <input accept="image/*" class="js-file" data-index="${index}" style="display: none;", type="file" name="item[item_imgs_attributes][${index}][url]" id="item_item_imgs_attributes_${index}_url">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

  $('#image-input').on('change', '.js-file', function(e) {
    console.log("12行目イベント発火");
    // $('#image-input__label:first').remove();
    // fileIndexの先頭の数字を使ってinputを作る
    $('#image-input').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    // 末尾の数に1足した数を追加する
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
  });

  $('#image-input').on('click', '.js-remove', function() {
    $(this).parent().remove();
    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-input').append(buildFileField(fileIndex[0]));
  });

  var file_field = document.querySelector('input[type=file]')
  $('.js-file').change(function(){
    console.log("27行目イベント発火");
    var file = $('input[type="file"]').prop('files')[0];
    var fileReader = new FileReader();
    fileReader.onloadend = function(){
      var src = fileReader.result
      var html= `<img src="${src}" width="114" height="80">`
      $('#image-input').before(html);
    }
    fileReader.readAsDataURL(file);
  });
});