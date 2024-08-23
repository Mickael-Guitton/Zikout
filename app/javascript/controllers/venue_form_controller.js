import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="venue-form"
export default class extends Controller {
  static targets = ["popup"];

  connect() {
    this.hidePopup();
    console.log("hello")
  }

  showPopup() {
    this.popupTarget.classList.remove("d-none")
  }

  hidePopup() {
    this.popupTarget.classList.add("d-none")
  }

  closePopup(event) {
    if (event.target === this.popupTarget) {
      this.hidePopup();
    }
  }
}
