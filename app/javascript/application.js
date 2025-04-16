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
import AwsS3 from '@uppy/aws-s3';
import SparkMD5 from 'spark-md5'

var isOnPage, regularize;

var onPageLoad = function(controller_and_actions, callback) {
  var conditions;
  conditions = regularize(controller_and_actions);
  if (!conditions) {
    console.error('[onPageLoad] Unexpected arguments!');
    return;
  }
  return conditions.forEach(function(a_controller_and_action) {
    var action, controller, ref;
    ref = a_controller_and_action.split('#'), controller = ref[0], action = ref[1];
    if (isOnPage(controller, action)) {
      return callback();
    }
  });
};

regularize = function(controller_and_actions) {
  if (typeof controller_and_actions === 'string') {
    return [controller_and_actions];
  } else if (Object.prototype.toString.call(controller_and_actions).includes('Array')) {
    return controller_and_actions;
  } else {
    return null;
  }
};

isOnPage = function(controller, action) {
  var selector;
  selector = "body[data-controller='" + controller + "']";
  if (action) {
    selector += "[data-action='" + action + "']";
  }
  return $(selector).length > 0;
};

function md5Base64(arrayBuffer) {
    const hex = SparkMD5.ArrayBuffer.hash(arrayBuffer, false)
    const rawBytes = hex.match(/.{2}/g).map(h => parseInt(h, 16))
    const byteString = String.fromCharCode(...rawBytes)
    return btoa(byteString)
}

async function computeChecksumInChunks(blob, chunkSize = 1024 * 1024) {
    const spark = new SparkMD5.ArrayBuffer();
    const fileSize = blob.size;
    let offset = 0;

    while (offset < fileSize) {
        const chunk = blob.slice(offset, offset + chunkSize);
        const buffer = await chunk.arrayBuffer();
        spark.append(buffer);
        offset += chunkSize;
    }

    const rawMD5 = spark.end(); // hex string
    const rawBytes = rawMD5.match(/.{2}/g).map(h => parseInt(h, 16));
    const byteString = String.fromCharCode(...rawBytes);
    return btoa(byteString);
}

if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('/service-worker.js')
            .then(registration => {
            })
            .catch(error => {
            });
    });
}
onPageLoad('videos#new', function() {
    const uppy = new Uppy({
        autoProceed: true
    })
        .use(Dashboard, {
            target: '#uppy-dashboard',
            inline: true
        })
        .use(AwsS3, {
            shouldUseMultipart: true,
            endpoint: '/',
        })

        uppy.on('file-added', async (file) => {
            console.log("Added file:", file)
            console.log("File data available:", file.data instanceof Blob) // trueならOK
            console.log("File name:", file.name)
            console.log("File type:", file.type)
            console.log("File size:", file.size)
            try {
                const checksum = await computeChecksumInChunks(file.data);
                file.meta.checksum = checksum // 後で使えるように保存
                console.log("checksum", checksum)
            } catch (err) {
                console.error("ファイル読み込みに失敗しました:", err)
            }
        })
    
        uppy.on('upload-success', async (file, response) => {
            console.log('Upload successful:', response);
            // key を推定する
            const key = new URL(response.uploadURL).pathname.slice(1)
            console.log("Key:", key)
            const checksum = file.meta.checksum
    
            fetch('/videos/register_blob', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content
            },
            body: JSON.stringify({
                blob: {
                filename: file.name,
                content_type: file.type,
                byte_size: file.size,
                checksum: checksum,
                key: key
                }
            })
            })
            .then(res => res.json())
            .then(data => {
                console.log("signed_id", data.signed_id)
                document.querySelector("#uploaded_video").value = data.signed_id
            })
        })
});
