import { Application } from "@hotwired/stimulus"
//= require datetime_picker_input

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
