import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { card_index: { type: Number, default: 0 }}

  initialize() {
    this.card_index = 0
    // initial button control value
  }
  // submit a study result asyncronously and update card_index
  // TODO: get an argument from the button, Not Confident, Confident, and Done.
  study_submit() {
    // TODO send a post request to update understanding_level if needed
    this.card_index = this.card_index + 1
  }

}