import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"

console.log("Starting Stimulus application");

const application = Application.start()

// 個別のコントローラーのインポートと登録
import SearchFormController from "./search_form_controller"
application.register("search-form", SearchFormController)

import FavoriteController from "./favorite_controller"
application.register("favorite", FavoriteController)

// 他のコントローラーの自動登録
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

console.log("Stimulus loaded");

window.Stimulus = application

export { application }