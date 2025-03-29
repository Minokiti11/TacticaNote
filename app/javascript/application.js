// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"

import jquery from "jquery"
window.$ = jquery;

import "./channels";
import "@rails/actioncable";
// import Popper from "popper.js"
import "bootstrap"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
import "trix"
import "@rails/actiontext"

import Uppy from '@uppy/core';
import Dashboard from '@uppy/dashboard';
import ActiveStorageUpload from "./utils/uppy-activestorage-uploader";
//import AwsS3Multipart from '@uppy/aws-s3-multipart';

if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('/service-worker.js')
            .then(registration => {
            })
            .catch(error => {
            });
    });
}

document.addEventListener('turbo:load', () => {
    document.querySelectorAll('[data-uppy]').forEach(element => setupUppy(element))
})

function setupUppy(element) {
    let trigger = element.querySelector('[data-behaviour="uppy-trigger"]')
    let form = element.closest("form");
    let direct_upload_url = document.querySelector("meta[name='direct-upload-url']").getAttribute("content")
    let field_name = element.dataset.uppy

    trigger.addEventListener("click", (event) => event.preventDefault())

    let uppy = Uppy({
        autoProceed: true,
        allowMultipleUploads: true,
        logger: Uppy.debugLogger
    })

    uppy.use(ActiveStorageUpload, {
        directUploadUrl: direct_upload_url
    })

    uppy.use(Dashboard, {
        trigger: trigger,
        closeAfterFinish: true,
    })

    uppy.on('complete', (result) => {
        console.log(result)
    })
}
