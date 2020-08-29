$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input accept="image/*" class="js-file" data-index="${index}" style="display: none;" type="file"
                    name="item[item_imgs_attributes][${index}][url]"
                    id="item_item_imgs_attributes_${index}_url">
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <img data-index="${index}" src="${url}" width="100px" height="100px">
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const newBuildImg = (index, url)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <img data-index="${index}" src="${url}" width="100px" height="100px">
                  </div>`;
    return html;
  }
  // $(document).on("click", '.imgdelete', function(){
  //   //プレビュー要素を取得
  //   var target_image = $(this).parent()
  //   //プレビューを削除
  //   target_image.remove();
  //   //inputタグに入ったファイルを削除
  //   file_field.val("")
  // })

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
  $('.hidden-destroy').hide();

  $('#image-input').on('change', '.js-file', function(e) {
    // labelタグのfor属性を変更
    $('#image-input__label').attr('for', 'item_item_imgs_attributes_' + fileIndex[0] + '_url');
    // fileIndexの先頭の数字を使ってinputを作る
    $('#image-input').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    // 末尾の数に1足した数を追加する
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    const url = location.href
    if (url == "http://localhost:3000/items/new") {
      $('#image-input').before(newBuildImg(targetIndex, blobUrl));
    } else {
      $('#image-input').before(buildImg(targetIndex, blobUrl));
    }
  });

  $('.output-box').on('click', '.js-remove', function(){
    const targetIndex = $(this).parent().data('index')
    console.log(targetIndex);
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
  });
});



// $(document).on("click", '.sell-main__delete-image', function(){
//   //プレビュー要素を取得
//   var target_image = $(this).parent().parent()
//   //プレビューを削除
//   target_image.remove();
//   //inputタグに入ったファイルを削除
//   file_field.val("")
// })