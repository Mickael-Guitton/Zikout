import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="venue-form"
export default class extends Controller {
  static targets = ["popup"];

  connect() {
    this.hidePopup();
  }

  showPopup() {
    this.popupTarget.style.display = "block";
  }

  hidePopup() {
    this.popupTarget.style.display = "none";
  }

  closePopup(event) {
    if (event.target === this.popupTarget) {
      this.hidePopup();
    }
  }
}
