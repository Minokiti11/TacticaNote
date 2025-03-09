# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "jquery", to: "jquery.min.js", preload: true

# Uppy関連のパッケージを追加
pin "@uppy/core", to: "https://ga.jspm.io/npm:@uppy/core@3.8.0/dist/uppy.min.js"
pin "@uppy/dashboard", to: "https://ga.jspm.io/npm:@uppy/dashboard@3.7.1/dist/uppy-dashboard.min.js"
pin "@uppy/aws-s3-multipart", to: "https://ga.jspm.io/npm:@uppy/aws-s3-multipart@3.10.0/dist/uppy-aws-s3-multipart.min.js"

pin "channels", to: "channels.js"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin "popper", to: "@popperjs/core"
pin "bootstrap", to: "bootstrap.min.js"
pin "@rails/activestorage", to: "activestorage.esm.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin_all_from "app/javascript", under: "javascript"
