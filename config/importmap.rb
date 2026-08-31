# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "fuse.js", to: "https://ga.jspm.io/npm:fuse.js@6.6.2/dist/fuse.esm.js"
pin "grass-rules", to: "grass-rules.js"
pin "fuse-index", to: "fuse-index.js"
