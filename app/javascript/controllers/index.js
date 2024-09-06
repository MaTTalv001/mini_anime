import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import SearchFormController from "./search_form_controller"

const application = Application.start()
application.register("search-form", SearchFormController)

const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

console.log("Stimulus loaded")

window.Stimulus = application