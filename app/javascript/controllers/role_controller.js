import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="role"
export default class extends Controller {
  static targets = ["roleSelect", "roleButton", "tenantForm", "actForm", "musicianForm"];

  connect() {
    this.selectedRole = null;
  }

  selectRole(event) {
    const role = event.currentTarget.dataset.role;

    this.roleSelectTarget.value = role;
    this.toggleFields()
    this.highlightButton(event);

  }
  highlightButton(event) {
    console.log(event);
    const role = event.currentTarget.dataset.role;

    if (!role) {
      console.error("Role is undefined");
    }

    if (this.selectedRole) {
      this.selectedRole.classList.remove("selected-role");
    }

    event.currentTarget.classList.add("selected-role");
    this.selectedRole = event.currentTarget;

    this.roleButtonTarget.value = role;

    this.toggleFields(role);
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
