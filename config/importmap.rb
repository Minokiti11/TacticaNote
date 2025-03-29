# Pin npm packages by running ./bin/importmap

pin "application"

pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@8.0.3/app/javascript/turbo/index.js"
pin "@rails/actioncable/src", to: "https://ga.jspm.io/npm:@rails/actioncable@7.1.3/src/index.js"
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@rails/actioncable", to: "https://ga.jspm.io/npm:@rails/actioncable@7.1.3-2/app/assets/javascripts/actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@8.0.3/dist/turbo.es2017-esm.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "@rails/activestorage", to: "https://ga.jspm.io/npm:@rails/activestorage@7.1.3-2/app/assets/javascripts/activestorage.esm.js"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.9/src/index.js"
pin "trix", to: "https://unpkg.com/trix@2.1.7/dist/trix.umd.min.js", preload: true
pin "@rails/actiontext", to: "actiontext.js"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "trix"

pin "@uppy/core", to: "@uppy--core.js" # @4.4.3
pin "@transloadit/prettier-bytes", to: "@transloadit--prettier-bytes.js" # @0.3.5
pin "@uppy/store-default", to: "@uppy--store-default.js" # @4.2.0
pin "@uppy/utils/lib/Translator", to: "@uppy--utils--lib--Translator.js" # @6.1.1
pin "@uppy/utils/lib/findDOMElement", to: "@uppy--utils--lib--findDOMElement.js" # @6.1.1
pin "@uppy/utils/lib/generateFileID", to: "@uppy--utils--lib--generateFileID.js" # @6.1.1
pin "@uppy/utils/lib/getFileNameAndExtension", to: "@uppy--utils--lib--getFileNameAndExtension.js" # @6.1.1
pin "@uppy/utils/lib/getFileType", to: "@uppy--utils--lib--getFileType.js" # @6.1.1
pin "@uppy/utils/lib/getTextDirection", to: "@uppy--utils--lib--getTextDirection.js" # @6.1.1
pin "@uppy/utils/lib/getTimeStamp", to: "@uppy--utils--lib--getTimeStamp.js" # @6.1.1
# pin "lodash/throttle.js", to: "lodash--throttle.js.js" # @4.17.21
pin "mime-match" # @1.0.2
pin "namespace-emitter" # @2.0.1
pin "nanoid/non-secure", to: "nanoid--non-secure.js" # @5.1.5
pin "preact" # @10.26.4
pin "wildcard" # @1.1.2

pin "@uppy/dashboard", to: "@uppy--dashboard.js" # @4.3.2
# pin "@uppy/utils", to: "https://cdn.jsdelivr.net/npm/@uppy/utils@6.1.1/dist/uppy-utils.min.js"
pin "@uppy/informer", to: "@uppy--informer.js" # @4.2.1
pin "@uppy/provider-views", to: "@uppy--provider-views.js" # @4.4.1
pin "@uppy/status-bar", to: "@uppy--status-bar.js" # @4.1.2
pin "@uppy/thumbnail-generator", to: "@uppy--thumbnail-generator.js" # @4.1.1
pin "@uppy/utils/lib/FOCUSABLE_ELEMENTS", to: "@uppy--utils--lib--FOCUSABLE_ELEMENTS.js" # @6.1.1
pin "@uppy/utils/lib/VirtualList", to: "@uppy--utils--lib--VirtualList.js" # @6.1.1
pin "@uppy/utils/lib/dataURItoBlob", to: "@uppy--utils--lib--dataURItoBlob.js" # @6.1.1
pin "@uppy/utils/lib/emaFilter", to: "@uppy--utils--lib--emaFilter.js" # @6.1.1
pin "@uppy/utils/lib/findAllDOMElements", to: "@uppy--utils--lib--findAllDOMElements.js" # @6.1.1
pin "@uppy/utils/lib/getDroppedFiles", to: "@uppy--utils--lib--getDroppedFiles.js" # @6.1.1
pin "@uppy/utils/lib/isDragDropSupported", to: "@uppy--utils--lib--isDragDropSupported.js" # @6.1.1
pin "@uppy/utils/lib/isObjectURL", to: "@uppy--utils--lib--isObjectURL.js" # @6.1.1
pin "@uppy/utils/lib/isPreviewSupported", to: "@uppy--utils--lib--isPreviewSupported.js" # @6.1.1
pin "@uppy/utils/lib/prettyETA", to: "@uppy--utils--lib--prettyETA.js" # @6.1.1
pin "@uppy/utils/lib/remoteFileObjToLocal", to: "@uppy--utils--lib--remoteFileObjToLocal.js" # @6.1.1
pin "@uppy/utils/lib/toArray", to: "@uppy--utils--lib--toArray.js" # @6.1.1
pin "@uppy/utils/lib/truncateString", to: "@uppy--utils--lib--truncateString.js" # @6.1.1
pin "classnames" # @2.5.1
pin "eventemitter3" # @5.0.1
pin "exifr/dist/mini.esm.mjs", to: "exifr--dist--mini.esm.mjs.js" # @7.1.3
pin "lodash", to: "https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"
pin "memoize-one" # @6.0.0
pin "p-queue" # @8.1.0
pin "p-timeout" # @6.1.4
pin "preact/hooks", to: "preact--hooks.js" # @10.26.4
pin "shallow-equal" # @3.1.0

