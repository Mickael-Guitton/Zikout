import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="role"
export default class extends Controller {
  static targets = ["tenantFields", "roleSelect"];

  connect() {
    console.log("Hi there!")
    this.toggleFields();
  }

  toggleFields() {
    if (this.roleSelectTarget.value === "tenant") {
      this.tenantFieldsTarget.style.display = "block";
    } else {
      this.tenantFieldsTarget.style.display = "none";
    }
  }
}
