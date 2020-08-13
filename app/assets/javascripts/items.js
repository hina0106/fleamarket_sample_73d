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

// $(document).on('turbolinks:load', function(){
//   $(function(){
//     // カテゴリーセレクトボックスのオプションを作成
//     function appendOption(category){
//       var html = `<option value="${category.id}">${category.name}</option>`;
//       return html;
//     }
//     // 子カテゴリーの表示作成
//     function appendChidrenBox(insertHTML){
//       var childSelectHtml = '';
//       childSelectHtml = `<div class='select_collection_select-category_add'id='child_wrapper'>
//                           <div class='select_collection_select-category1'>
//                             <select id="child_category" name="item[category_id]">
//                               <option value="">選択してください</option>
//                               ${insertHTML}
//                             <select>
//                           </div>
//                         </div>`;
//       $('.select_collection_select-category').append(childSelectHtml);
//     }

//     // 孫カテゴリーの表示作成
//     function appendGrandchidrenBox(insertHTML){
//       var grandchildSelectHtml = '';
//       grandchildSelectHtml = `<div class='select_collection_select-category_add'id='grandchild_wrapper'>
//                                 <div class='select_collection_select-category2'>
//                                   <select id="grandchild_category" name="item[category_id]">
//                                     <option value="">選択してください</option>
//                                     ${insertHTML}
//                                   <select>
//                                 </div>
//                               </div>`;
//       $('.select_collection_select-category').append(grandchildSelectHtml);
//     }

//     // 親カテゴリー選択後のイベント
//     $('#parent_category').on('change', function(){
//       var parent_category_id = document.getElementById
//       ('parent_category').value; //選択された親カテゴリーの名前を取得
//       if (parent_category_id!= "選択してください"){ //親カテゴリーが初期値でないことを確認
//         $.ajax({
//           url: 'get_category_child',
//           type: 'GET',
//           data: { parent_id: parent_category_id },
//           dataType: 'json'
//         })
//         .done(function(child){
//           $('#child_wrapper').remove(); //親が変更された時、子以下を削除する
//           $('#grandchild_wrapper').remove();
//           var insertHTML = '';
//           child.forEach(function(child){
//             insertHTML += appendOption(child);
//           });
//           appendChidrenBox(insertHTML);
//         })
//         .fail(function(){
//           alert('カテゴリー取得に失敗しました');
//         })
//       }else{
//         $('#child_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
//         $('#grandchild_wrapper').remove();
//       }
//     });

//     // 子カテゴリー選択後のイベント
//     $('.select_collection_select-category').on('change','#child_category', function(){
//       var child_category_id = $('#child_category option:selected')[0].value; //選択された子カテゴリーのidを取得
//       if (child_category_id != "選択してください"){ //子カテゴリーが初期値でないことを確認
//         $.ajax({
//           url: 'get_category_grandchild',
//           type: 'GET',
//           data: { child_id: child_category_id },
//           dataType: 'json'
//         })
//         .done(function(grandchild){
//           if (grandchild.length != 0) {
//             $('#grandchild_wrapper').remove(); //子が変更された時、孫以下を削除する
//             var insertHTML = '';
//             grandchild.forEach(function(grandchild){
//               insertHTML += appendOption(grandchild);
//             });
//             appendGrandchidrenBox(insertHTML);
//           }
//         })
//         .fail(function(){
//           alert('カテゴリー取得に失敗しました');
//         })
//       }else{
//         $('#grandchild_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
//       }
//     });
//   });
// });
