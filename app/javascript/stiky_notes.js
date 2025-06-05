document.addEventListener("turbo:load", function () {
    // 既存メモを再構築
    document.querySelectorAll(".note").forEach(note => {
      const comicId = note.dataset.comicId;
      const noteId = note.dataset.id;
      const notableType = note.dataset.notableType;
      const content = note.querySelector("textarea")?.value || "";
  
      note.innerHTML = "";
  
      const closeBtn = document.createElement("button");
      closeBtn.innerText = "×";
      closeBtn.className = "delete-button";
      Object.assign(closeBtn.style, {
        position: "absolute",
        top: "2px",
        right: "4px",
        background: "transparent",
        border: "none",
        cursor: "pointer",
        fontWeight: "bold",
        fontSize: "16px",
        color: "#d00"
      });
      closeBtn.onclick = () => deleteNote(note);
      note.appendChild(closeBtn);
  
      const textArea = document.createElement("textarea");
      textArea.value = content;
      textArea.addEventListener("input", () => updateNoteContent(textArea));
      note.appendChild(textArea);
    // 追記

    setTimeout(() => {
      const targetId = localStorage.getItem("focusTargetId");
      if (!targetId) return;
  
      const note = document.getElementById(targetId);
      const textarea = note?.querySelector("textarea");
      if (textarea) {
        textarea.focus();
        const len = textarea.value.length;
        textarea.setSelectionRange(len, len);
  
        note.classList.add("highlight");
        setTimeout(() => {
          note.classList.remove("highlight");
        }, 2000);
      }
  
      localStorage.removeItem("focusTargetId");
    }, 300); // 少し長めに待つことでDOM構築のタイミングを確保
    //
  
      makeNoteDraggable(note);
    });
  
    // ＋ボタンイベント
    document.querySelectorAll(".add-note").forEach(button => {
      button.addEventListener("click", function () {
        console.log("＋ボタン押されました"); // ←ここ追加
        const comicId = this.dataset.comicId;
        const notableType = this.dataset.notableType;
        if (comicId && notableType) addDraggableNote(comicId, notableType);
      });
    });
  });



  function getStikyNoteBasePath(comicId, notableType) {
    const pathType = notableType === "panel" ? "panels" : "story_parts";
    return `/comics/${comicId}/${pathType}/stiky_notes`;
  }
  
  window.addDraggableNote = function (comicId, notableType) {
    const url = getStikyNoteBasePath(comicId, notableType);
  
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({
        stiky_note: {
          note_content: "新しいメモ",
          position_x: Math.random() * (window.innerWidth - 150),
          position_y: Math.random() * (window.innerHeight - 150),
          notable_type: notableType
        }
      })
    })
      .then(response => response.json())
      .then(data => {
        const noteContainer = document.getElementById("note-container");
        if (!noteContainer) return;
  
        const note = createNoteElement(data, comicId, notableType);
        noteContainer.appendChild(note);
        makeNoteDraggable(note);
      });
  };
  
  window.updateNoteContent = function (textarea) {
    const note = textarea.closest(".note");
    const comicId = note.dataset.comicId;
    const noteId = note.dataset.id;
    const notableType = note.dataset.notableType;
    const url = getStikyNoteBasePath(comicId, notableType) + `/${noteId}`;
  
    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ stiky_note: { note_content: textarea.value } })
    });
  };
  
  window.deleteNote = function (note) {
    const comicId = note.dataset.comicId;
    const noteId = note.dataset.id;
    const notableType = note.dataset.notableType;
    const url = getStikyNoteBasePath(comicId, notableType) + `/${noteId}`;
  
    if (!confirm("このメモを削除しますか？")) return;
  
    fetch(url, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      }
    }).then(response => {
      if (response.ok) {
        note.remove();
      } else {
        alert("削除に失敗しました");
      }
    });
  };
  
  function makeNoteDraggable(note) {
    let offsetX, offsetY;
    let isDragging = false;
  
    note.addEventListener("mousedown", function (event) {
      if (
        event.target.tagName === "TEXTAREA" ||
        event.target.classList.contains("delete-button")
      ) return;
  
      isDragging = true;
      offsetX = event.clientX - note.getBoundingClientRect().left;
      offsetY = event.clientY - note.getBoundingClientRect().top;
  
      note.style.zIndex = 1000;
  
      document.addEventListener("mousemove", onMouseMove);
      document.addEventListener("mouseup", onMouseUp);
    });
  
    function onMouseMove(event) {
      if (!isDragging) return;
      note.style.left = `${event.pageX - offsetX}px`;
      note.style.top = `${event.pageY - offsetY}px`;
    }
  
    function onMouseUp() {
      if (!isDragging) return;
      isDragging = false;
  
      document.removeEventListener("mousemove", onMouseMove);
      document.removeEventListener("mouseup", onMouseUp);
  
      updateNotePosition(note);
    }
  }
  
  function updateNotePosition(note) {
    const comicId = note.dataset.comicId;
    const noteId = note.dataset.id;
    const notableType = note.dataset.notableType;
    const position_x = parseFloat(note.style.left);
    const position_y = parseFloat(note.style.top);
    const url = getStikyNoteBasePath(comicId, notableType) + `/${noteId}`;
  
    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ stiky_note: { position_x, position_y } })
    });
  }
  
  function createNoteElement(data, comicId, notableType) {
    const note = document.createElement("div");
    note.className = "note";
    note.style.left = `${data.position_x}px`;
    note.style.top = `${data.position_y}px`;
    note.dataset.id = data.id;
    note.dataset.comicId = comicId;
    note.dataset.notableType = notableType;
    note.id = `stikynote-${data.id}`; 
  
    const closeBtn = document.createElement("button");
    closeBtn.innerText = "×";
    closeBtn.className = "delete-button";
    Object.assign(closeBtn.style, {
      position: "absolute",
      top: "2px",
      right: "4px",
      background: "transparent",
      border: "none",
      cursor: "pointer",
      fontWeight: "bold",
      fontSize: "16px",
      color: "#d00"
    });
    closeBtn.onclick = () => deleteNote(note);
  
    const textArea = document.createElement("textarea");
    textArea.value = data.note_content;
    textArea.addEventListener("input", () => updateNoteContent(textArea));
  
    note.appendChild(closeBtn);
    note.appendChild(textArea);
  
    return note;
  }