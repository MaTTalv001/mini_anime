// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
console.log("Application.js loaded")
import * as ActiveStorage from "@rails/activestorage"
import "channels"

ActiveStorage.start()
import { Turbo } from "@hotwired/turbo-rails"

// Turboを有効にする
Turbo.session.drive = true

// 特定のフォームやリンクでTurboを無効にする
document.addEventListener('turbo:load', () => {
  document.querySelectorAll('form[data-turbo="false"]').forEach(form => {
    form.addEventListener('submit', (event) => {
      event.preventDefault()
      event.target.submit()
    })
  })