import { Controller } from "@hotwired/stimulus"

console.log("Favorite controller loaded");

export default class extends Controller {
    connect() {
        console.log("Favorite controller connected", this.element);
      }

  toggle(event) {
    console.log("Toggle method called", event.currentTarget);
    event.preventDefault()
    const button = event.currentTarget
    const workId = button.dataset.workId
    const isFavorite = button.classList.contains('btn-error')

    console.log(`Toggling favorite for work ID: ${workId}, current state: ${isFavorite ? 'favorite' : 'not favorite'}`)

    const url = isFavorite ? `/favorites/${workId}` : '/favorites'
    const method = isFavorite ? 'DELETE' : 'POST'

    fetch(url, {
      method: method,
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ work_id: workId })
    })
    .then(response => {
      console.log("Response received:", response)
      return response.json()
    })
    .then(data => {
      console.log("Data received:", data)
      if (data.status === 'success') {
        button.classList.toggle('btn-success')
        button.classList.toggle('btn-error')
        button.textContent = isFavorite ? 'お気に入り' : 'お気に入り解除'
        console.log("Button updated successfully")
      } else {
        console.error('Error:', data.message)
      }
    })
    .catch(error => {
      console.error('Error:', error)
    })
  }
}