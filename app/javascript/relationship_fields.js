document.addEventListener("turbo:load", function () {
  const container = document.getElementById("relationships-container");
  const addButton = document.getElementById("add-relationship-button");
  const template = document.getElementById("relationship-template");

  if (!container || !addButton || !template) {
    console.error("必要な要素が見つかりません");
    return;
  }

  addButton.addEventListener("click", function () {
    const index = container.querySelectorAll(".relationship-block").length;
    let newForm = template.innerHTML.replace(/NEW_INDEX/g, index);
    container.insertAdjacentHTML("beforeend", newForm);
  });

  container.addEventListener("click", function (event) {
    if (event.target.classList.contains("remove-relationship-button")) {
      event.target.closest(".relationship-block").remove();
    }
  });
});