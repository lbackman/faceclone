import { Controller } from "@hotwired/stimulus"
import debounce from "debounce"

// Connects to data-controller="form"
export default class extends Controller {
  static values = {
    timeout: Number
  }

  connect() {
  }

  initialize() {
    this.submit = debounce(this.submit.bind(this), this.timeoutValue)
  }

  submit() {
    this.element.requestSubmit()
  }
}
