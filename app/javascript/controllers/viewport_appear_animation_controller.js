import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const element = this.element;
    const animationOffset = 110; // Offset para activar la animación
    let parallaxFactor = parseFloat(element.dataset.parallaxFactor) || 0.5; // Factor de parallax predeterminado
    let animationDuration = 800; // Duración de la animación predeterminada
    let animationDirection = "bottom"; // Dirección de animación predeterminada
    let rotateDegrees = "-90deg"; // Grados de rotación predeterminados

    // Almacenar el estado de las animaciones
    const originalTransform = element.style.transform;
    const originalTransition = element.style.transition;
    const originalOpacity = element.style.opacity;
    const originalPointerEvents = element.style.pointerEvents;

    // Aplicar estilos de animación inicial
    element.style.transition = `transform ${animationDuration}ms, opacity ${animationDuration}ms`;
    updateAnimation();

    // Función para verificar si el elemento está en el viewport
    function isInViewport() {
      return element.getBoundingClientRect().top <= (window.innerHeight - animationOffset);
    }

    // Función para actualizar la animación según la posición del elemento en el viewport
    function updateAnimation() {
      const inViewport = isInViewport();
      if (!inViewport) {
        restoreOriginalAnimationState(); // Restaurar el estado original si el elemento está fuera del viewport
      }
      element.style.transform = `translateY(${inViewport ? '0' : '25px'})`;
      element.style.opacity = inViewport ? "1" : "0";
      element.style.pointerEvents = inViewport ? "auto" : "none";
    }

    // Función para aplicar el efecto parallax
    function applyParallax(parallaxType) {
      switch(parallaxType) {
        case "simple":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = `translateY(${calculateParallaxAmount(parallaxFactor)})`;
          break;
        case "reverse":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = `translateY(${calculateParallaxAmount(-parallaxFactor)})`;
          break;
        case "fixed":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = `translateY(${calculateParallaxAmount(0)})`;
          break;
        case "smooth":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = `translateY(${calculateParallaxAmount(parallaxFactor * 0.5)})`;
          break;
        case "zoom":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = `translateY(${calculateParallaxAmount(parallaxFactor * 1.5)})`;
          break;
        // Agrega más casos para otros tipos de parallax según sea necesario
        default:
          break;
      }
      function calculateParallaxAmount(factor) {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        return (element.getBoundingClientRect().top - scrollTop) * factor + "px";
      }
    }

    // Restaurar el estado original de las animaciones si el elemento sale del viewport
    function restoreOriginalAnimationState() {
      element.style.transform = originalTransform;
      element.style.opacity = originalOpacity;
      element.style.pointerEvents = originalPointerEvents;
      element.style.transition = `opacity ${animationDuration}ms`;
      element.style.transform = `translateY(0px) translateX(0px) scale(1) rotateY(0deg) rotateX(0deg)`;
    }
    
    // Obtener la animación del atributo data-animation
    const animationType = element.dataset.animation;
    if (element.dataset.animationDuration) {
      animationDuration = parseInt(element.dataset.animationDuration);
    }
    if (element.dataset.animationDirection) {
      animationDirection = element.dataset.animationDirection;
    }
    if (element.dataset.rotateDegrees) {
      rotateDegrees = element.dataset.rotateDegrees;
    }

    // Manejar el evento de scroll para actualizar la animación y el efecto parallax
    window.addEventListener("scroll", () => {
      updateAnimation();
      applyParallax(element.dataset.parallax); // Separar múltiples tipos de parallax por espacio
        
      // Verificar la animación y aplicarla
      switch(animationType) {
        case "fade-in":
          element.style.transition = `opacity ${animationDuration}ms`;
          break;
        case "slide-in":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = `translate${animationDirection === 'left' ? 'X(-100%)' : animationDirection === 'right' ? 'X(100%)' : animationDirection === 'top' ? 'Y(-100%)' : animationDirection === 'bottom' ? 'Y(100%)' : 'Y(100%)'}`;
          break;
        case "scale-in":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = "scale(0)";
          break;
        case "rotate-in":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = `rotate(${rotateDegrees})`;
          break;
        case "flip-in":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = "rotateY(-90deg)";
          break;
        case "bounce-in":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = "translateY(0)";
          break;
        case "fade-slide-in":
          element.style.transition = `opacity ${animationDuration}ms, transform ${animationDuration}ms`;
          element.style.transform = `translate${animationDirection === 'left' ? 'X(-20px)' : animationDirection === 'right' ? 'X(20px)' : animationDirection === 'top' ? 'Y(-20px)' : 'Y(20px)'}`;
          break;
        case "rotate-fade-in":
          element.style.transition = `opacity ${animationDuration}ms, transform ${animationDuration}ms`;
          element.style.transform = "rotate(0) scale(1)";
          break;
        case "scale-bounce-in":
          element.style.transition = `transform ${animationDuration}ms`;
          element.style.transform = "scale(0) translateY(0)";
          break;
        case "flip-fade-in":
          element.style.transition = `opacity ${animationDuration}ms, transform ${animationDuration}ms`;
          element.style.transform = "rotateY(0) scale(1)";
          break;
        case "3d-background":
          element.style.transition = `transform ${animationDuration}ms, opacity ${animationDuration}ms`;
          element.style.transform = "rotateX(30deg)";
          break;
        case "3d-overlay":
          const rotateXDirection = animationDirection === 'left' ? '5deg' : animationDirection === 'right' ? '-5deg' : '0deg';
          element.style.transition = `transform ${animationDuration}ms, opacity ${animationDuration}ms`;
          element.style.transform = `translateY(-60px) scale(1.2) rotateY(30deg) rotateX(${rotateXDirection})`;
          break;
        default:
          // Si la animación no está definida, se aplica la animación predeterminada
          element.style.transition = `transform ${animationDuration}ms, opacity ${animationDuration}ms`;
          break;
      }
      applyParallax(element.dataset.parallax); // Separar múltiples tipos de parallax por espacio
    });
  }
}
