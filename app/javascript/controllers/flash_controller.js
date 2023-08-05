import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.dismiss();
    }, 5000);
  }

  dismiss() {
    const fadeOutDuration = 200;
    this.element.animate({
        opacity: 0
      }, {
        duration: fadeOutDuration,
        easing: "linear",
        iterations: 1,
        fill: "both"
    });

    setTimeout(() => this.element.remove(), fadeOutDuration);
  }
}
