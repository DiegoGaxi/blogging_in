import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["nav","navbar", "toggler"];

  toggleSidebar() {
    this.navbarTarget.classList.toggle("open");
    this.navbarTarget.classList.toggle("closed");
    this.navTarget.classList.toggle("blurred", this.navbarTarget.classList.contains("open"));
  }

  connect() {
    this.togglerTarget.addEventListener("click", () => {
      this.toggleSidebar();
    });
  }
}
