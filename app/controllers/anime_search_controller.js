import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["year", "season", "search"]

  connect() {
    console.log("AnimeSearchController connected")
    this.updateFormState()
  }

  updateFormState() {
    console.log("Updating form state")
    if (this.hasYearTarget && this.hasSeasonTarget && this.hasSearchTarget) {
      const yearValue = this.yearTarget.value
      this.toggleSeasonSelect(yearValue)
      this.updateSearchButtonState()
    } else {
      console.error("One or more required targets are missing")
    }
  }

  toggleSeasonSelect(yearValue) {
    console.log("Toggling season select", yearValue)
    if (yearValue) {
      this.seasonTarget.disabled = false
      this.seasonTarget.required = true
    } else {
      this.seasonTarget.disabled = true
      this.seasonTarget.required = false
      this.seasonTarget.value = ''
    }
    console.log("Season select disabled:", this.seasonTarget.disabled)
  }

  updateSearchButtonState() {
    const yearValue = this.yearTarget.value
    const seasonValue = this.seasonTarget.value
    
    if (yearValue) {
      this.searchTarget.disabled = !seasonValue
    } else {
      this.searchTarget.disabled = false
    }
    console.log("Search button disabled:", this.searchTarget.disabled)
  }

  yearChanged() {
    console.log("Year changed", this.yearTarget.value)
    this.updateFormState()
  }

  seasonChanged() {
    console.log("Season changed", this.seasonTarget.value)
    this.updateSearchButtonState()
  }
}