document.addEventListener("DOMContentLoaded", function () {
    console.log("JavaScript is loaded!");
  
    const container = document.getElementById("relationships-container");
    console.log("Container:", container);
  
    const addButton = document.getElementById("add-relationship-button");
    console.log("Add Button:", addButton);
  
    const templateDiv = document.getElementById("relationship-template");
    if (!templateDiv) {
      console.error("エラー: relationship-template が見つかりません！");
      return;
    }
  
    addButton.addEventListener("click", function () {
      console.log("追加ボタンが押されました！");
  
      // インデックス番号を取得
      const index = container.children.length;
      console.log("現在のフォーム数:", index);
  
      // `relationship-template` 内のHTMLを取得
      let newFormHtml = templateDiv.innerHTML.replace(/\[\d+\]/g, `[${index}]`);
      newFormHtml = newFormHtml.replace(/\_\d+\_/g, `_${index}_`);
  
      // `relationships-container` に新しいフォームを追加
      container.insertAdjacentHTML("beforeend", newFormHtml);
      console.log("フォームが追加されました！");
    });
  
    // 削除ボタンの処理
    container.addEventListener("click", function (event) {
      if (event.target.classList.contains("remove-relationship-button")) {
        console.log("削除ボタンが押されました！");
        event.target.closest(".relationship-block").remove();
      }
    });
  });