import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="role"
export default class extends Controller {
  static targets = ["roleSelect", "tenantForm", "actForm", "musicianForm"];

  selectRole(event) {
    const role = event.currentTarget.dataset.role;
    this.roleSelectTarget.value = role;
    this.toggleFields();
  }

  toggleFields() {
    const role = this.roleSelectTarget.value;

    // Hide all forms initially
    this.tenantFormTarget.style.display = "none";
    this.actFormTarget.style.display = "none";
    this.musicianFormTarget.style.display = "none";

    // Show the form based on the selected role
    if (role === "tenant") {
      this.tenantFormTarget.style.display = "block";
    } else if (role === "act") {
      this.actFormTarget.style.display = "block";
    } else if (role === "musician") {
      this.musicianFormTarget.style.display = "block";
    }
  }
}
