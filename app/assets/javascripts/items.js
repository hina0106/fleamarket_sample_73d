$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<input accept="image/*" class="js-file" data-index="${index}" style="display: none;", type="file" name="item[item_imgs_attributes][${index}][url]" id="item_item_imgs_attributes_${index}_url">`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

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
    $('#image-input').before(buildImg(targetIndex, blobUrl));
  });
});

$(document).on('click', '.sell-main__delete-image', function(){
  $(this).parents('.sell-main__upload-item').remove();
  let uploadItemLength = $(uploadItems).children('li').length;
  $(uploadItems).removeClass().addClass(sell-main__upload-items sell-main__upload-items--have-item-${uploadItemLength % 5});
  $(uploadDropBox).removeClass().addClass(sell-main__upload-drop-box sell-main__upload-drop-box--have-item-${uploadItemLength % 5});
});
// カテゴリーの選択欄追加
function appendCategory(){
  let subHTML = `<div class="sell-main__select-wrap">
                <i class="fas fa-chevron-down"></i>
                <select class="sell-main__select-default" name="product[category_id]">
                  <option value="">--</option>
                </select>
                </div>`;
  $(categoryWrapper).append(subHTML);
}
// カテゴリーの選択内容追加
function appendOption(category, appendWrap){
  let subOptionHTML =<option value="${category.id}", data-size-id="${category.size}", data-brand-id="${category.brand}">${category.name}</option>;
  $(appendWrap).children('select').append(subOptionHTML);
}
function attrCustomData(category, appendWrap, index){
  $(appendWrap).children('select').children(option:nth-child(${index + 2})).attr({
    'data-size-id': category.size,
    'data-brand-id': category.brand,
  });
}
const categoryWrapper = '#sell-main__select-category--wrapper';
const mainCategory = '#sell-main__select-category--main';
const subCategory = '#sell-main__select-category--wrapper div:nth-child(2)';
const subSubCategory = '#sell-main__select-category--wrapper div:nth-child(3)';
const sizeWrap = '#sell-main__form-group--size';
const brandWrap = '#sell-main__form-group--brand';
// メインカテゴリー選択時、サブカテゴリー追加
$(mainCategory).on('change', function(){
  let sub = $(this).val();
  let sub_sub = "0";
  $.ajax({
    type: "GET",
    url: '/items/category_children',
    data: { sub: sub, sub_sub: sub_sub  },
    dataType: 'json'
  })
  .done(function(categories){
    $(subSubCategory).remove();
    $(subCategory).remove();
    $(sizeWrap).remove();
    appendSizeNull();
    $(brandWrap).remove();
    if(sub != ''){
      appendCategory();
      categories.forEach(function(category){
        appendOption(category, subCategory);
      });
    }
  })
  .fail(function(){
    alert('カテゴリー検索に失敗しました');
  });
});
// サブカテゴリー選択時、サブサブカテゴリー追加
$(document).on('change', subCategory, function(){
  let sub = $(mainCategory).val();
  let sub_sub = $(this).children('select').val();
  $.ajax({
    type: "GET",
    url: '/items/category_children',
    data: {sub: sub, sub_sub: sub_sub},
    dataType: 'json'
  })
  .done(function(categories){
    $(subSubCategory).remove();
    $(sizeWrap).remove();
    appendSizeNull();
    $(brandWrap).remove();
    if(sub_sub != '' && categories[0]){
      appendCategory();
      categories.forEach(function(category){
        appendOption(category, subSubCategory);
      });
    }
  })
  .fail(function(){
    alert('カテゴリー検索に失敗しました');
  });
})
// // 編集時、カテゴリー追加
// if(document.URL.match(/sell/) && document.URL.match(/edit/)) {
//   $(document).ready(function(){
//     let sub = $(mainCategory).val();
//     let sub_sub = $(subCategory).children('select').val();
//     $.ajax({
//       type: "GET",
//       url: '/items/category_children',
//       data: { sub: sub, sub_sub: sub_sub },
//       dataType: 'json'
//     })
//     .done(function(categories){
//       if(sub != ''){
//         categories.forEach(function(category, index){
//           attrCustomData(category, subSubCategory, index);
//         });
//       }
//     })
//     .fail(function(){
//       alert('カテゴリー編集に失敗しました');
//     });
//   });
// }