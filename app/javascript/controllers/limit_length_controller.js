import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "field", "output" ]
  static classes = [ "overLimit" ]
  static values = {
    characterCount: Number,
  }

  connect() {
    this.change()
  }

  change() {
    let length = this.fieldTarget.value.length
    this.outputTarget.textContent = `${length}/${this.characterCountValue} characters`

    if (length > this.characterCountValue) {
      this.outputTarget.classList.add(this.overLimitClass)
    } else {
      this.outputTarget.classList.remove(this.overLimitClass)
    }
  }
}
