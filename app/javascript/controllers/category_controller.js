import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { editTarget: { type: Number, default: 0 }}

  initialize() {
    this.editType = 0
    // initial button control value
  }

  // TODO: change the editType when buttons are clicked
  categoryTapped() {
    this.editType = 0
    this.editTargetChange()
  }

  cardsTapped() {
    this.editType = 1
    this.editTargetChange()
  }

  editTargetChange() {

  }

  // connect to the button in adding a new card
  addCard() {

  }

}