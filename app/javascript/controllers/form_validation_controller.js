import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.actualizarEstadoBotonSubmit();
    this.agregarEventListeners();
  }

  agregarEventListeners() {
    const inputs = Array.from(this.element.querySelectorAll('textarea, input, select'));
    inputs.forEach(input => {
      input.addEventListener('input', async () => {
        await this.actualizarEstadoBotonSubmit();
      });
    });
  }

  verificarCamposLlenos() {
    const inputs = Array.from(this.element.querySelectorAll('textarea, input, select'));
    return inputs.every(input => {
      if (input.required) {
        return input.value.trim() !== ''; // Verificar campos requeridos no ocultos
      }
      return true; // Otros campos que no son requeridos
    });
  }

  actualizarEstadoBotonSubmit() {
    const submitButton = this.element.querySelector('[type="submit"]');
    if (this.verificarCamposLlenos()) {
      submitButton.disabled = false;
    } else {
      submitButton.disabled = true;
    }
  }

  submit() {
    if (!this.verificarCamposLlenos()) {
      event.preventDefault(); // Evitar envío si campos no están llenos
    }
  }
}
