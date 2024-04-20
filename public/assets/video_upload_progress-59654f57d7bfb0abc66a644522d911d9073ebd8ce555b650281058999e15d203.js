// $(document).on('turbo:load', function () {
//     // イベントリスナーの設定
//     console.log("passed.");
//     document.addEventListener("direct-upload:initialize", event => {
//         const { target, detail } = event
//         const { id, file } = detail
//         const container = target.parentNode
    
//         const progressElement = document.createElement("div")
//         progressElement.id = `direct-upload-progress-${id}`
//         progressElement.className = "direct-upload__progress"
//         progressElement.style.width = "0%"
    
//         const filenameElement = document.createElement("div")
//         filenameElement.className = "direct-upload__filename"
//         filenameElement.textContent = file.name
    
//         const progressContainer = document.createElement("div")
//         progressContainer.className = "direct-upload direct-upload--pending"
//         progressContainer.id = `direct-upload-${id}`
//         progressContainer.appendChild(progressElement)
//         progressContainer.appendChild(filenameElement)
    
//         container.insertBefore(progressContainer, target.nextSibling)
//     })

//     document.addEventListener("direct-upload:start", event => {
//         const { id } = event.detail
//         const element = document.getElementById(`direct-upload-${id}`)
//         element.classList.remove("direct-upload--pending")
//     })

//     document.addEventListener("direct-upload:progress", event => {
//         const { id, progress } = event.detail
//         const progressElement = document.getElementById(`direct-upload-progress-${id}`)
//         progressElement.style.width = `${progress}%`
//     })

//     document.addEventListener("direct-upload:error", event => {
//         event.preventDefault()
//         const { id, error } = event.detail
//         const element = document.getElementById(`direct-upload-${id}`)
//         element.classList.add("direct-upload--error")
//         element.setAttribute("title", error)
//     })

//     document.addEventListener("direct-upload:end", event => {
//         const { id } = event.detail
//         const element = document.getElementById(`direct-upload-${id}`)
//         element.classList.add("direct-upload--complete")
//     })
// });


document.getElementById("video_upload").addEventListener("direct-upload:initialize",
function() {
    console.log('direct-uploads:initialize')
});
