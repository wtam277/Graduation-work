
// panelのedit,newの画像プレビュー
document.addEventListener("DOMContentLoaded", function () {
    window.updateCharacter = function (select) {
      const selectedOption = select.options[select.selectedIndex];
      const iconUrl = selectedOption.getAttribute("data-icon");
      const imageTag = select.closest(".speech-block").querySelector(".character-preview");

      if (iconUrl && iconUrl !== '') {
        imageTag.src = iconUrl;
        imageTag.style.display = "block";
      } else {
        imageTag.src = "";
        imageTag.style.display = "none";
      }
    };
  });