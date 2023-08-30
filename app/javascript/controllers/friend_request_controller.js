import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="friend-request"
export default class extends Controller {
  static values = {
    id: Number
  }

  connect() {
    console.log(this.idValue)
  }

  removeElement() {
    document.getElementById(`friend_request_${this.idValue}`).remove()
  }
}
