import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["year", "season", "button"]

  connect() {
    console.log("SearchFormController connected")
    this.updateSearchButtonState()
  }

  yearChanged() {
    console.log("Year changed:", this.yearTarget.value)
    if (this.yearTarget.value) {
      this.seasonTarget.disabled = false
      this.seasonTarget.required = true
    } else {
      this.seasonTarget.disabled = true
      this.seasonTarget.required = false
      this.seasonTarget.value = ''
    }
    this.updateSearchButtonState()
  }

  seasonChanged() {
    console.log("Season changed:", this.seasonTarget.value)
    this.updateSearchButtonState()
  }

  updateSearchButtonState() {
    const shouldEnable = (this.yearTarget.value && this.seasonTarget.value) || (!this.yearTarget.value && !this.seasonTarget.value)
    console.log("Updating button state:", shouldEnable)
    this.buttonTarget.disabled = !shouldEnable
  }
  
}
console.log("SearchFormController loaded")