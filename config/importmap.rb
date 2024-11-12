# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails",
    to: "../../../.rbenv/versions/3.3.6/lib/ruby/gems/3.3.0/gems/turbo-rails-2.0.11/app/assets/javascripts/turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "../app/javascript/controllers", under: "controllers"
