import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var notification = this.element

    // Oculta la notificación después de 5 segundos
    setTimeout(function() {
      notification.style.animation = 'slideOutDown 0.5s ease-out';
      setTimeout(function() {
        notification.style.display = 'none';
      }, 500);
    }, 5000);

    this.showNotification(notification);
  }

  showNotification(notification) {
    notification.style.display = 'block';
  }
}