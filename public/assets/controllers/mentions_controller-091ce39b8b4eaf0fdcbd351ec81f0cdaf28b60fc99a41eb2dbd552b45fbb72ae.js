import { Controller } from "@hotwired/stimulus"
import Tribute from "tribute"
import Trix from "trix"

export default class extends Controller {
    static targets = [ "field" ]
    connect() {
        this.editor = this.fieldTarget.editor
        this.initializeTribute()
    }

    disconnect() {
        this.tribute.detach(this.fieldTarget)
    }

    initializeTribute() {
        this.tribute = new Tribute({
            allowSpaces: true,
            lookup: 'username',
            values: this.fetchUsers,
            trigger: '@'
        })
        this.tribute.attach(this.fieldTarget)
        this.tribute.range.pasteHtml = this._pasteHtml.bind(this)
        this.fieldTarget.addEventListener("tribute-replaced", this.replaced)

        // @が入力された時にスペースを挿入するイベントリスナーを追加
        this.fieldTarget.addEventListener("keydown", this.handleAtSymbol.bind(this))
    }

    fetchUsers(text, callback) {
        fetch(`/mentions.json?query=${text}`)
            .then(response => response.json())
            .then(users => callback(users))
            .catch(error => callback([]))
    }

    replaced(e) {
        let mention = e.detail.item.original
        let attachment = new Trix.Attachment({
            content: `<span class="mention" style="color: #1f7790;">@${mention.username}</span>`
        })
        
        this.editor.insertAttachment(attachment)
        this.editor.insertString(" ")
    }

    _pasteHtml(html, startPos, endPos) {
        let position = this.editor.getPosition()
        this.editor.setSelectedRange([position - 1, position])
        this.editor.deleteInDirection("backward")
    }

    // @が入力された時にスペースを挿入するメソッドを追加
    handleAtSymbol(event) {
        if (event.key === '@') {
            let position = this.editor.getPosition()
            if (position > 0 && this.editor.getDocument().getCharacterAtPosition(position - 1) !== ' ') {
                event.preventDefault()
                this.editor.insertString(' @')
            }
            else
            {
                event.preventDefault()
                this.editor.insertString('@')
            }
        }
    }
};
