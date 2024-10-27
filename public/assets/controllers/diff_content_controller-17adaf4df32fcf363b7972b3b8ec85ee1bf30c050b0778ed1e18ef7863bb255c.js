import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("Hello, I'm diff_content_controller.js!!");
        // Turbo Stream がレンダリングされるたびに this.updateNoteGood を呼び出す
        document.addEventListener("turbo:before-stream-render", this.updateNoteGood.bind(this))
    }

    updateNoteGood(event) {
        const newStream = event.detail.newStream;

        const target = newStream.getAttribute('target');

        const template = newStream.querySelector("template");

        // targetが "notes_good" の場合のみ処理
        if (target === "notes_good") {
            console.log("template: ", template);
            const notesGoodElement = template.content.querySelector('#notes_good');
            const diffElement = notesGoodElement.children[0];
            if (diffElement) {
                const diffContent = diffElement.getAttribute('data-diff-content');
                const noteGood = document.getElementById('note_good');
                // noteGoodのdata-suggestion-changedをtrueに設定
                $('#note_good').data('suggestion-changed', true);
                if (noteGood && noteGood.editor) {
                    // let attachment = new Trix.Attachment({
                    //     content: `${diffContent}`
                    // })
                    // noteGood.editor.insertAttachment(attachment);

                    // "理由: "の位置を特定
                    const splitPosition = diffContent.indexOf("理由:");

                    // "理由: "が見つからない場合の処理
                    if (splitPosition === -1) {
                        return [diffContent, ""];
                    }

                    // "理由: "以降の文字列を取得
                    const originalText = diffContent.slice(0, splitPosition);
                    const addedText = diffContent.slice(splitPosition);
                    console.log("originalText: ", originalText);
                    console.log("addedText: ", addedText);

                    const cleanedOriginalText = originalText.replace(/\n/g, '');

                    // originalTextをエディタから探し、その末尾にaddedTextを追加する
                    const documentText = noteGood.editor.getDocument().toString();
                    const index = documentText.indexOf(cleanedOriginalText.toString());
                    console.log(index);
                    if (index == -1) {
                        console.warn("originalTextが見つかりませんでした。");
                    } else {
                        const insertPosition = index + cleanedOriginalText.length;
                        console.log(insertPosition);
                        console.log("selected Range: ", noteGood.editor.getSelectedRange());
                        noteGood.editor.setSelectedRange([insertPosition, insertPosition]);
                        
                        noteGood.editor.insertHTML(`<div><span class="highlight-green">${addedText.replace(/\n/g, '<br>')}</span></div>`);
                        noteGood.editor.setSelectedRange([insertPosition + addedText.replace(/\n/g, '').length + 1, insertPosition + addedText.replace(/\n/g, '').length + 1]);
                    }
                }
            }
        }
    }

    getInsertionRange(editor) {
        const { start, end } = editor.getSelectedRange();
        return { start, end };
    }
};
