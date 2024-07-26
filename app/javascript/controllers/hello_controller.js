import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // connect is the method called when it connects
  connect() {
    this.element.textContent = "Hello World!"
  }
}
